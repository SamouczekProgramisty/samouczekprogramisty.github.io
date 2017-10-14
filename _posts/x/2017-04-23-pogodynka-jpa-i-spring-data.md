---
layout: single
title: Pogodynka - JPA i Spring Data
date: '2017-04-23 20:45:31 +0200'
categories:
- DSP2017
- Projekty
- Pogodynka
excerpt_separator: "<!--more-->"
permalink: "/pogodynka-jpa-i-spring-data/"
---
Raport z frontu Pogodynki część 6. Dzisiaj pokrótce opisuję konfigurację warstwy dostępu do bazy danych. Sama konfiguracja skończyła się na dodaniu kilku zależności i magicznych adnotacji, które postaram się wyjaśnić.

# Baza danych
  
Dla celów testowych i na “środowisku developerskim” (czytaj moim własnym komputerze) używam prostej bazy danych. Mam tu na myśli [HyperSQL](http://hsqldb.org/). Jest to baza danych, której zawartość może być trzymana wyłącznie w pamięci.

Tego typu rozwiązanie idealnie nadaje się do pracy na środowisku programistycznym. Często też bazy danych tego typu używane są w trakcie testów integracyjnych. W trakcie takich testów możliwe jest testowanie właściwej integracji z bazą danych.

Dostęp do tej bazy danych możliwy jest po dodaniu jednej linijki do konfiguracji Gradle

compile group: 'org.hsqldb', name: 'hsqldb', version: '2.4.0'

Jeśli chcesz dowiedzieć się czegoś więcej o samym Gradle zachęcam do przeczytania [wprowadzenia do Gradle](http://www.samouczekprogramisty.pl/wstep-do-gradle/).

# JPA i ORM
  
I tu wchodzą nam dwie wielkie kobyły ;). JPA czyli _Java Persistence API_ i ORM czyli _Object-Relational Mapping_. JPA to specyfikacja, która została włączona do specyfikacji EJB (ang. _Enterprise Java Beans_). Specyfikacja ta określa mechanizmy, które pozwalają na "proste" zarządzanie zawartością bazy danych przez obiekty w Java.

Innymi słowy instancje klas odpowiadają wierszom w bazie danych. Mapowanie zawartości bazy danych na obiekty Javy to “mapowanie obiektowo-relacyjne” - ORM. Najszerzej stosowaną implementacją JPA jest Hibernate. To właśnie tę implementację użyłem w Pogodynce. Aby uzyskać wsparcie Hibernate niezbędne są następujące zależności:

    compile group: 'org.hibernate', name: 'hibernate-entitymanager', version: '5.2.10.Final'compile group: 'org.hibernate', name: 'hibernate-core', version: '5.2.10.Final'

## ORM
  
Nie wchodząc w szczegóły samego JPA i Hibernate opiszę co udało mi się osiągnąć. Przy pomocy odpowiednich adnotacji w kodzie Javy mapuję obiekty klasy [`TemperatureMeasurement`](https://github.com/SamouczekProgramisty/Pogodynka/blob/master/datavault/src/main/java/pl/samouczekprogramisty/pogodynka/datavault/model/TemperatureMeasurement.java) na wiersze w tabeli `temperature_measurements`. Całość wymagała kilku adnotacji w kodzie oraz dodatkowej konfiguracji, która pozwoliła na mapowanie typu DateTime na odpowiedni typ w bazie danych.

Jedyny obiekt modelu, który aktualnie jest dostępny wygląda następująco:

    @Entity@Table(name = "temperature_measurements", indexes = @Index(name = "idx_temperature_measurements_when_meaasured", columnList = "when_measured"))public class TemperatureMeasurement { @Id @SequenceGenerator(name = "measurements_sequence", allocationSize = 5, sequenceName = "temperature_measurements_seq") @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "measurements_sequence") private Long id; private BigDecimal temperature; @Column(name = "when_measured") private DateTime whenMeasured; public TemperatureMeasurement() { } public TemperatureMeasurement(BigDecimal temperature, DateTime whenMeasured) { this.temperature = temperature; this.whenMeasured = whenMeasured } @NotNull public BigDecimal getTemperature() { return temperature; } @NotNull public DateTime getWhenMeasured() { return whenMeasured; }}

## Warstwa dostępu do danych
  
Warstwa DAO (ang. _Data Access Object_) jest automatycznie generowana. Są to obiekty pośredniczące zarządzane przez Spring. Interfejs DAO, którym posługuję się w aplikacji sprowadza się do kilku linijek:

    @Repositorypublic interface TemperatureMeasurementDAO extends CrudRepository {}

  
Taka “magia” dostępna jest dzięki użyciu Spring Data:

    compile group: 'org.springframework.data', name: 'spring-data-jpa', version: '1.11.3.RELEASE

# Magiczna konfiguracja Spring
  
Całość konfiguracji to jeden nowy plik. Tworzy on odpowiednie obiekty, które wymagane są przez specyfikację JPA

    @Configuration@EnableTransactionManagement@EnableJpaRepositories(basePackages = "pl.samouczekprogramisty.pogodynka.datavault.model")public class JPAConfigration { @Bean public DataSource getDataSource() { DriverManagerDataSource dataSource = new DriverManagerDataSource(); dataSource.setDriverClassName("org.hsqldb.jdbc.JDBCDriver"); dataSource.setUrl("jdbc:hsqldb:mem:datavault_test"); dataSource.setUsername("datavault_test"); dataSource.setPassword("datavault_test"); return dataSource; } @Bean public LocalContainerEntityManagerFactoryBean entityManagerFactory() { LocalContainerEntityManagerFactoryBean entityManager = new LocalContainerEntityManagerFactoryBean(); entityManager.setDataSource(getDataSource()); entityManager.setJpaVendorAdapter(new HibernateJpaVendorAdapter()); entityManager.setPackagesToScan("pl.samouczekprogramisty.pogodynka.datavault.model"); Properties jpaProperties = new Properties(); jpaProperties.setProperty("hibernate.dialect", "org.hibernate.dialect.HSQLDialect"); jpaProperties.setProperty("hibernate.show_sql", "true"); jpaProperties.setProperty("hibernate.format_sql", "true"); jpaProperties.setProperty("hibernate.hbm2ddl.auto", "create-drop"); jpaProperties.setProperty("jadira.usertype.autoRegisterUserTypes", "true"); entityManager.setJpaProperties(jpaProperties); return entityManager; } @Bean public PlatformTransactionManager transactionManager(EntityManagerFactory entityManagerFactory) { JpaTransactionManager transactionManager = new JpaTransactionManager(); transactionManager.setEntityManagerFactory(entityManagerFactory); return transactionManager; } @Bean public PersistenceExceptionTranslationPostProcessor exceptionTranslation() { return new PersistenceExceptionTranslationPostProcessor(); }}

# Podsumowanie
  
Na dzień dzisiejszy mam “gotową” aplikację webową, która wystawia dwa adresy URL. Pozwalają one na utworzenie nowej instancji pomiaru temperatury i pobrania wszystkich istniejących pomiarów. Kolejnym krokiem będzie zaimplementowanie “logowania” użytkowników i wystawienia takiej aplikacji na świat. Następnie będę mógł zintegrować czujnik z tak działającą aplikacją.

Po kilku dniach działania aplikacji będę miał wystarczająco dużo rzeczywistych pomiarów temperatury, które pozwolą mi na pracę nad interfejsem użytkownika.

Jeśli chcesz zobaczyć aktualną wersję aplikacji możesz ją znaleźć na [samouczkowym githubie](https://github.com/SamouczekProgramisty/Pogodynka/tree/master/datavault). Trzymaj się i do następnego razu!

[FM\_form id="3"]

Zdjęcie dzięki uprzejmości https://www.flickr.com/photos/rubysfeast/7149704201/sizes/l

