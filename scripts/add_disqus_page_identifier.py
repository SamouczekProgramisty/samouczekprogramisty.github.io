import os
import re
import glob

from git import Repo
from StringIO import StringIO

line_with_id = re.compile('^wordpress_id: (\d+)')

repo = Repo('.')
tree = repo.commit('a48c1af9a284a0abfb8b5d1a6bc59919bb4324f8').tree
posts = tree['_posts']

filename = '_posts/2015-10-22-metody-w-jezyku-java.md'


def get_oldname(filename):
    basename, _ = os.path.basename(filename).split('.')
    if basename == '2015-11-18-petle-i-instrukcje-warunkowe-w-jezyku-java':
        return '2015-11-18-petle-i-nstrukcje-warunkowe-w-jezyku-java.html'
    if basename == '2016-12-09-advent-of-code-2016-dzien-7':
        return '2016-12-09-advent-of-code-dzien-7.html'
    return basename + '.html'


def get_post_id(filename):
    oldname = get_oldname(filename)

    old_post_blob = posts[oldname]
    temp_stream = StringIO()
    old_post_blob.stream_data(temp_stream)
    temp_stream.seek(0)
    for line in temp_stream.readlines():
        match = line_with_id.match(line)
        if match:
            return int(match.group(1))

    raise RuntimeError('Nope. ' + filename)


for filename in glob.glob('_posts/*'):
    file_content = []
    identifier = get_post_id(filename)

    with open(filename) as f:
        frontmatter = 0
        for line in f:
            if line == '---\n':
                frontmatter += 1
            if frontmatter == 2:
                file_content.append('disqus_page_identifier: %d http://www.samouczekprogramisty.pl/?p=%d\n' % (identifier, identifier))
                frontmatter = 0
            file_content.append(line)

    with open(filename, 'w') as f:
        f.write(''.join(file_content))
