## MySQL 설치(window)

### (MySQL Community Server 5.7.22)

`https://dev.mysql.com/downloads/mysql/`



**압축 해제 및  환경변수 등록**

1. MYSQL 환경 변수 등록 

   - 시스템변수/PATH에   `~\mysql-5.7.22-winx64/bin` 등록
   - 시스템변수에 MYSQL  `~\mysql-5.7.22-winx64`

2. mysql 설치 폴더 하위에  `data` 폴더 생성

3. window command 실행

   ##### 1) mysql-5.7.22-winx64/data/ 초기 필요 파일 자동생성

   - `$ mysqld --initialize` 

   ##### 2) MySQL 서버를 기동 

   `$ mysqld --console --explicit_defaults_for_timestamp --skip-grant-tables`

4. 정상적인 실행이 되면 새로운 cmd 창 열기(root 계정 초기 설정)

   -  `$ mysql -u root mysql`  

   - `mysql> update USER set authentication_string=password('111111') where user='root'; `
   - `mysql> flush privileges;  `
   - `mysql> alter user 'root'@'localhost' identified by 'root1234', 'root'@'localhost' password expire never; `
   - 위 과정을 정상적으로 했다면 `mysql> exit` 
   - `$ mysql -u root -p` # 이젠 root 계정접속 가능

5. 서버 종료

   `mysqladmin -u root -p shutdown `

#####  

유저 계정 생성

```cmd 
$ mysqld -nt
```

```cmd
$ mysql -u root -p
mysql> create user username identified by 'password';
mysql> create user username@localhost identified by 'password';
```

**MySQL System Database 생성**

```cmd
mysql> create database library;
## 권한 부여
mysql> grant all privileges on library.* to username;
mysql> grant all privileges on library.* to username@localhost;
```

