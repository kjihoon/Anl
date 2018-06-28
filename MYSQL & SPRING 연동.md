## MYSQL & SPRING 연동

-  `Anl` project // convert DBsoftware to mysql
  - `MySQL` : MySQL 라이브러리
  - `MyBitis 3.4.1` : MyBitis 프레임워크
  - `MyBitis-Spring` : Spring과 MyBitis를 연결하는 라이브러리
  - `Spring-jdbc `: jdbc 라이브러리
  - `Spring-test` : 스프링과 MyBitis가 정상적으로 연동되었는지 확인하기 위해 필요한 라이브러리

```xml
<!--pom.xml-->

<!-- MySQL -->
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>6.0.5</version>
        </dependency>
 
        <!-- MyBatis 3.4.1 -->
        <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.4.1</version>
        </dependency>
 
 
        <!-- MyBatis-Spring -->
        <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>1.3.0</version>
        </dependency>
 
        <!-- Spring-jdbc -->
        <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>${org.springframework-version}</version>
        </dependency>
 
        <!-- Spring-test -->
        <!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>${org.springframework-version}</version>
        </dependency>

```





### MySQL JDBC 드라이버 Time Zone 이슈

`jdbc:mysql://127.0.0.1:3306/anl?serverTimezone=UTC` ?serverTimezone=UTC로 해결

