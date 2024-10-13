/*
CHAPTER 1 : General Statement---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1. SQL可以单行也可以多行书写，以分号结尾；
2. SQL语句可使用空格/缩进来增加可读性；
3. MySQL数据库的statement不区分大小写，但是关键字建议使用大写；
4.注释： 单行注释：--  或者  #(MySQL only)
		 多行注释

讲解顺序：
S1: DDL: data definition language, 用来定义数据库的对象如：数据库，表，字段
S2: DML：data manipulation language, 用来对数据库表中的数据进行增删改
S3: DQL：data query language, 查询数据库中表的记录
S4: DCL：data control language, 用来创建数据库用户、控制数据库的访问权限：有哪些用户可以访问，每个用户具有什么样的访问权限。
*/



/*
CHAPTER 2 : SQL---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------C2S1：DDL 数据库操作----------------------------------------
1. 查询所有数据库
show database;
show databases;
2. 查询当前数据库
select database();
3. 创建
create database [ if not exists ] 数据库名 [ default charset 字符集 ] [ collate 排序规则 ];
4. 删除
drop database [ if exists ] 数据库名;
5. 使用
use 数据库名;
*/
/*
###S1 代码演示：
create database itcast;
show databases;
create database if not exists itcast;
create database itfuck default charset utf8mb4; 
drop database if exists sys;
use itcast;
select database();
*/

/*
----------------------------------------C2S2：DDL 表操作----------------------------------------
1.查询当前数据库的所有表
	show tables;
2.查询表结构
	desc 表名;
3.查询指定的建表语句
	show create table biaoming；
4.创建表
	create table 表名(
		字段1 字段1类型, [comment 字段1注释],
		...... ,
		字段n 字段n类型  [comment 字段n注释]
	) [comment 表注释];
5. data type
	int: an integer with value between -231 and 231-1
	decimal(m, d): a floating-point number with total m digits and d digits after decimal point	float(7,4): 999.5436
	char(n): a string with n characters char(8): 'ISM 4930', 'ISM 3113' … 性能高
	varchar(n): a string with at most n characters Varchar(25): 'Aiken', 'Letersky' … 性能较差（需要自己去计算使用空间）
	date Recognized format: 'YYYY-MM-DD' or 'YY-MM-DD' (e.g., '2009-01-23' or '09-01-23')
6. 添加字段
	alter table 表名 add 字段名 类型(长度) [comment 注释] [约束];
7. 修改字段
	alter table 表名 change 旧字段名 新字段名 类型(长度) [comment 注释] [约束];
8. 删除字段
	alter table 表名 drop 字段名;
9. 修改表名
	alter table 表名 rename to 新表名;
10. 删除表
	drop table [if exists] 表名; 或者
	truncate table 表名;
*/
/*
###S2 代码演示1：
###设计一个淘宝用户信息管理表
use itcast;
create table tb_user(
	id			int 			comment 'number',
    username	varchar(50) 	comment 'Name',
    age			int 			comment 'age',
    gender		varchar(1) 		comment 'Sex'
) comment 'tb user info table';
show tables;
desc tb_user;
show create table tb_user;
*/
/*
###S2 代码演示2：
###设计一个员工信息表
use itcast;
create table emp(
	id 			int 				comment 'work id',
    workno 		varchar(10) 		comment 'work number',
    workname 	varchar(10) 		comment  'Name',
    gender 		char(1) 			comment 'sex',
    age 		tinyint unsigned 	comment 'Age',
    idcard 		char(18) 			comment 'Idcardnum',
    entrydate 	date 				comment 'entry date'
) comment 'work info table';
desc emp;
*/
/*
###S2 代码演示3：
##给表添加字符段
alter table emp add nickname varchar(20);
##修改字段名和类型
alter table emp change nickname username varchar(30);
##删除字段名
alter table emp drop username;
##修改表名
alter table emp rename to emploee;
desc emp;
show tables;
##删除表
drop table if exists emp comment'删表删数据';
truncate table emp comment'删数据创建空表';
*/

/*
----------------------------------------C2S3：DML 表操作----------------------------------------
一、添加数据 insert
	1.给指定字段添加数据
		insert into 表名 (字段名1, 字段名2, ...) values (值1, 值2, ...);
	2.给全部字段添加数据
		insert into 表名 values (值1, 值2, ...);
	3.批量添加数据
		insert into 表名(字段名1, 字段名2, ...) values(值1, 值2, ...),(值1, 值2, ...),(值1, 值2, ...);
		insert into 表名 values(值1, 值2, ...),(值1, 值2, ...),(值1, 值2, ...);
	ps: 
		1) 插入数据时，指定的字段顺序需要与值得顺序时一一对应的;
		2)字符串和日期数据应该被包含在引号当中;
		3)插入的数据大小，应该在字段的规定范围内。
二、修改数据 update
	update 表名 set 字段名1=值1，字段名2=值2，....[where 条件]; 
三、删除数据 delete
	delete from 表名 [where 条件]
	ps:delete语句得条件可以有，也可以没有，如果没有条件，则会删除整张表的所有数据。
	delete语句不能删除某一个字段的值(可以使用update, 把这个字段设为null)。
*/
/*
###S3 代码演示：
SELECT * FROM itcast.emploee;
use itcast;
insert into emploee(id, workno, workname, gender, age, idcard, entrydate) values(1, '1', 'Itcast', 'M', 10, '123456789', '2000-01-01');
insert into emploee(id, workno, workname, gender, age, idcard, entrydate) values(2, '2', 'Itcast', 'M', 12, '123456789', '2000-01-02');
insert into emploee value (2, '2', 'zhang', 'M', 18, '1234567890', '2005-01-01');
insert into emploee value (3, '3', 'wei', 'M', 38, '1234567890', '2005-01-01'), (4, '4', 'zhao', 'F', 18, '1234567890', '2005-01-01');
update emploee set workname = 'itheima' where id = 1;
update emploee set workname = 'xiaozhao', gender = 'F' where id = 1;
update emploee set entrydate = '2008-01-01';
delete from emploee where gender  = 'F';
delete from emploee;
*/

/*
----------------------------------------C2S4：DQL 表操作----------------------------------------
编写顺序：
	select
		字段列表
	from
		表名列表
	where
		条件列表
	group by
		分组字段列表
	having
		分组后条件列表
	order by
		排序字段列表
	limit
		分页参数
实际执行顺序：
	from
		表名列表
	where
		条件列表
	group by
		分组字段列表
	having
		分组后条件列表
	select
		字段列表
	order by
		排序字段列表
	limit
		分页参数
    
1.基本查询 (select)
	select 字段1[as nickname1]，字段2[as nickname2]，字段3... from 表名;
    select from 表名;
    select distinct 字段列表 from 表名;
2.条件查询（where）
	select 字段列表 from 表名 where 条件列表;
		ps:条件列表：
			一、比较运算符：
				>, >=, <, <=, =, <>或!=, 
				between...and... 在某个范围内含最小值最大值,between跟最小值，and跟最大值，
				in(...) 在in之后的列表中的值，多选一, 
				like 占位符 模糊匹配，_匹配单个字符，%匹配任意个字符，
				is null 是null
			二、逻辑运算符：
				and或&& 并且（多个条件同时成立）
				or或|| （多个条件任意一个成立）
				not或！ 非，不是
3.聚合函数（count、max、min、avg、sum）
	将一列数据作为一个整体，进行纵向计算，所有的null值不参与聚合函数的计算！
    count 统计数量
    max
    min
    avg
    sum
    select 聚合函数（字段列表） from 表名;
4.分组查询（group by）
	select 字段列表 from 表名 [where 条件] group by 分组字段名 [having 分组后的过滤条件] 
		#where是对分组前的数据进行过滤，having是对分组后的数据进行过滤。
        #where不能对聚合函数进行判断，而having可以。
		#执行顺序：where > 聚合函数 > having。
        #分组之后，查询的字段一般为聚合函数和分组字段，查询其他的字段无意义。
5.排序查询（order by）
	select 字段列表 from 表名 order by 字段1 排序方式1，字段2 排序方式2；
		#ASC：升序（default）
        #DESC：降序
6.分页查询（limit）
	select 字段列表 from 表名 limit 起始索引，查询记录数;
		#起始索引从0开始，起始索引 = (查询页码-1) * 每页显示的记录数；
        #分页查询是数据库的方言，不同的数据库有不同的实现，MySQL中是limit；
        #如果是查询的是第一页的数据，起始索引可以省略，直接简写为limit 10。
*/
/*
###S4 代码演示1：
#首先创建一个table case
drop table emploee;
create table emp(
	id			int,
    workno		varchar(10),
    workname	varchar(10),
    gender		char(1),
    age			tinyint unsigned,
    idcard		char(18),
    workaddress varchar(50),
    entrydate	date
) comment'table of employees';
insert into emp (id, workno, workname, gender, age, idcard, workaddress, entrydate)
values  (1, '1', 'liu', 'F', 20, '123456789012340178', 'Bejing', '2000-01-01'),
		(2, '2', 'zhang', 'M', 18, '123456789012345008', 'Bejing', '2005-05-01'),
        (3, '3', 'wei', 'M', 38, '123456789012895678', 'Shanghai', '2001-07-01'),
		(4, '4', 'zhao', 'F', 18, '123365789012345678', 'Bejing', '2004-01-01'),
        (5, '5', 'xiao', 'F', 16, '123456789552345678', 'Shanghai', '2003-10-01'),
        (6, '6', 'yang', 'M', 28, '123456789012347778', 'Beijing', '2001-09-01'),
		(7, '7', 'fan', 'M', 40, '123456779012345678', 'Bejing', '2001-01-15'),
        (8, '8', 'dai', 'F', 38, '123456789010345678', 'Tianjing', '2001-12-01'),
        (9, '9', 'fang', 'F', 45, '123456789012385678', 'Bejing', '2006-06-01'),
		(10, '10', 'chen', 'M', 53, '123456789012375678', 'Shanghai', '2007-11-01'),
        (11, '11', 'shi', 'M', 55, '123456789013345678', 'Jiangsu', '2004-10-01'),
        (12, '12', 'chang', 'M', 32, '123056789012345678', 'Bejing', '2002-12-01'),
		(13, '13', 'feng', 'M', 88, '123476789012345678', 'Jiangsu', '2008-01-02'),
        (14, '14', 'mie', 'F', 65, '123466789012345678', 'Xian', '2000-01-06'),
        (15, '15', 'hu', 'M', 78, '12345678901234567X', 'Xian', '2001-01-01'),
		(16, '16', 'zhou', 'F', 18, null, 'Bejing', '2012-06-01');
#下面演示---------------------基本查询---------------------
##查询指定的字段如：workname workno age 返回
select workname,workno,age from emp;
##查询所有的字段返回
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp; #这样写麻烦但一般都这样写，让别人只看这一行代码也能读懂
select * from emp; #一般在公司开发不这样使用通配符，否则公司该让你滚蛋了
##查询所有员工的工作地址，起别名
select workaddress from emp; 
select workaddress as 'Work Address' from emp; #workaddress可读性不强，所以起一个别名
select workaddress 'Work Address' from emp; #as可以省略
##查询公司员工的上班地址(不要重复)
select distinct workaddress 'Work Address' from emp; #去重操作
#下面演示---------------------条件查询---------------------
##查询年龄等于88的员工
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age = 88;
##查询年龄小于20的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age < 20;
##查询年龄小于等于20的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age <= 20;
##查询没有身份证号的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where idcard is null;
##查询有身份证号的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where idcard is not null;
##查询年龄不等于88的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age != 88;
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age <> 88;
##查询年龄在15-20之间，包含边界的员工
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age >= 15 and age <= 20;
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age >= 15 && age <= 20;
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age between 15 and 20;
##查询性别为女，且年龄<25岁的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where gender = 'F' and age < 25;
##查询年龄等于18或28或40的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age = 18 or age = 20 or age = 40;
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where age in(18,20,40);
##查询姓名为三个字母的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where workname like'___'; #下划线是占位符，几个下划线几个字符
##查询身份证号最后为X的员工信息
select id, workno, workname, gender, age, idcard, workaddress, entrydate from emp where idcard like'%X';
#下面演示---------------------聚合函数---------------------
##统计该企业员工的数量
select count(*) from emp; #统计所有样本数量
select count(id) from emp;
select count(idcard) from emp;
##统计该企业员工的平均年龄
select avg(age) from emp;
##统计该企业员工的最大年龄
select max(age) from emp;
##统计该企业员工的最小年龄
select min(age) from emp;
##统计西安地区员工的年龄之和
select sum(age) from emp where workaddress = 'Xian';
#下面演示---------------------分组查询---------------------
##根据性别分组，分别统计男性员工和女性员工的数量
select count(*) from emp group by gender;
select gender, count(*) from emp group by gender;
##根据性别分组，分别统计男性员工和女性员工的平均数量
select gender, avg(age) from emp group by gender;
##查询年龄小于45的员工，并根据工作地址分组，获取员工数量大于等于3的工作地址
select workaddress, count(*) from emp where age < 45 group by workaddress having count(*) >= 3;
#下面演示---------------------排序查询---------------------
##根据年龄对公司的员工进行升序排序
select * from emp order by age;
select * from emp order by age asc;
select * from emp order by age desc;
##根据入职时间对员工进行降序排序
select * from emp order by entrydate desc;
##根据年龄对公司的员工进行升序排序，如果年龄相同，再按照入职时间进行降序排序
select * from emp order by age asc, entrydate desc;
#下面演示---------------------分页查询---------------------
##查询第一页员工的数据，每页展示10条记录
select * from emp limit 0, 10;
select * from emp limit 10;
##查询第二页员工的数据，每页展示10条记录
select * from emp limit 10, 10;
*/

/*
----------------------------------------C2S5：DCL 管理用户----------------------------------------
1.查询用户
	use mysql;
	select * from user;
2.创建用户
	create user 'username'@'主机名' identified by '密码';
3.修改用户密码
	alter user 'username'@'主机名' identified with mysql_native_password by 'new密码';
4.删除用户
	drop user 'username'@'主机名';
ps:
	主机名可以使用%通配。
    这类SQL开发人员操作地比较少，主要是DBA（database administer 数据库管理员）使用。
*/
/*
###S5 代码演示：
##创建用户itcast，只能在当前主机localhost访问，密码123456;
create user 'itcast'@'localhost' identified by '123456';
##创建用户heima，可以在任意主机访问该数据库，密码123456;
create user 'heima'@'%' identified by '123456';
##修改用户heima的访问密码为1234;
alter user 'heima'@'%' identified with native_mysql_password by '1234';
##删除itcast@localhost用户;
drop user 'itcast'@'localhost';
*/

/*
----------------------------------------C2S6：DCL 权限控制----------------------------------------
常用权限：
	all, all privileges		所有权限
	select					查询数据
    insert					插入数据
    update					修改数据
    delete 					删除数据
    alter					修改表
    drop 					删除数据库/表/视图
    create					创建数据库/表
1.查询权限
	show grants for 'username'@'主机名';
2.授权
	grant 权限列表 on 数据库名.表名 to 'username'@'主机名';
3.撤销权限
	revoke 权限 on 数据库.数据库表 from ‘用户名’@‘ip’ ;
ps：
	多个权限之间，使用逗号分隔；
    授权时，数据库名和表名可以使用*进行通配，代表所有。
*/
/*
###S6 代码演示：
##查询权限
show grants for 'heima'@'%';
##授权
grant all on itcast.* to 'heima'@'%';
##撤销权限
revoke all privileges on itcast.* from 'heima'@'%';
*/



/*
CHAPTER 3 : 函数---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------C3S1：字符串函数---------------------------------------
常用的字符串函数：
	concat(S1,S2,...Sn)			字符串拼接，将S1,S2,...Sn拼接为一个字符串
	lower(str)					将字符串转为小写
	upper(str)					将字符串转为大写
    lpad(str, n, pad)			左填充，用字符串pad对str的左边进行填充，达到n个字符串的长度
	rpad(str, n, pad)			右填充，用字符串pad对str的右边进行填充，达到n个字符串的长度
    trim(str)					去掉字符串头部和尾部的空格
    substring(str, start, len)	返回从str从start位置起的len个长度的字符串 注意一下这里的str起始index是1。
*/
/*
##concat
	select concat('Hello', 'MySQL');
##Lower
	select lower('Hello');
##Upper
	select upper('Hello');
##lpad
	select lpad('01', 5, '-');
##rpad
	select rpad('01', 5, '-');
##trim
	select trim (' hello  MySQL ');
##substring
	select substring('Hello MySQL', 1, 5);
##将员工工号统一为5位数，不足5位数的在前面补0。
update emp set workno = lpad(workno, 5, '0');
*/

/*
----------------------------------------C3S2：数值函数-----------------------------------------
常用的数值函数：
	ceil(x)		向上取整
	floor(x)	向下取整
    mod(x,y)	返回x/y的模
    rand()		返回0-1之间的随机数
    round(x,y)	求参数x的四舍五入的值，保留y位小数
*/
/*
##ceil
	select ceil(1.1);
##floor
	select floor(1.9);
##mod
	select mod(3,4);
##rand
	select rand();
##round
	select round(2.345, 2);
##通过数据库的函数，生成一个6位的随机验证码
	select lpad(round(rand()*1000000, 0), 6, 0);
*/

/*
----------------------------------------C3S3：日期函数-----------------------------------------
常见的日期函数：
	curdate()			返回当前日期
    curtime()			返回当前时间
    now()				返回当前日期和时间
    year(date)			获取指定date的年份
	month(date)			获取指定date的月份
    day(date)			获取指定date的日期
    date_add(date, interval expr type)		返回一个日期/时间加上一个时间间隔expr后的时间值
    datediff(date1, date2)			返回起始时间date1和结束时间date2之间的天数
*/
/*
##curdate()
	select curdate();
##curtime()
	select curtime();
##now
	select now();
##year, month, day
	select year(now());
	select month(now());
	select date(now());
##date_add
	select date_add(now(), interval 70 day); #往后推70天
    select date_add(now(), interval 70 year); 
##datediff
	select datediff('2021-12-01', '2021-10-01'); #求取两个日期之间的差值
    select datediff('2021-08-01', '2021-10-01'); #负数，前面-后面
##查询所有员工的入职天数，并根据天数倒序排序。
	select name, date(curdate(), entrydate) as 'entrydays' from emp order by entrydays desc;
*/

/*
----------------------------------------C3S4：流程函数-----------------------------------------
流程控制函数：在SQL语句中实现条件筛选，从而提高语句效率。
if(value, t, f)					如果value为true，则返回t，否则返回f
ifnull(value1, value2)			如果value1不为空，返回value1，否则返回value2
case when [val1] then [res1] ... else [default] end				如果val1为true，返回res1, ...否则返回dafault默认值
case [expr] when [val1] then [res1] ... else [default] end		如果expr的值等于val1，返回res1，...否则返回default默认值
*/
/*
##if
	select if(true, 'ok', 'error');
    select if(false, 'ok', 'error'); #通常情况下，true和false的地方应该是一个条件表达式
##ifnull
	select ifnull('ok', 'default');
    select ifnull('', 'default');
    select ifnull(null, 'default');
##case when then else end
##查询emp的员工姓名，工作地址（北京/上海-----一线城市，其他----二线城市）
	select 
		workname, 
		(case workaddress when 'Bejing' then 'first' when 'Shanghai' then 'First' else 'Second' end ) as 'Work City' 
	from emp;
##case:统计班级各个学员的成绩，展示规则如下：----->= 85, 展示优秀----->= 60, 展示及格------否则, 展示不及格
#首先创建case：
	create table score(
		id		int,
		stdname	varchar(20),
		math	int,
		english	int,
		chinese	int
	) comment('table of std scores');
    insert into score(id, stdname, math, english, chinese) values(1, 'Tom', 67,88,95), (2, 'Rose', 23, 66, 98), (3, 'Jack', 56, 98,76);
#开始写查询语句：
	select 
		id,
        stdname,
        (case when math >= 85 then 'excellence' when math >= 60 then 'Pass' else 'Fall' end) 'math', 
        (case when math >= 85 then 'excellence' when math >= 60 then 'Pass' else 'Fall' end) 'english', 
        (case when math >= 85 then 'excellence' when math >= 60 then 'Pass' else 'Fall' end) 'chinese' 
    from score;
*/



/*
CHAPTER 4 : 约束---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1.概念：约束是作用于表中字段上的规则，用于限制储存在表中的数据。
2.目的：保证数据库的数据的正确、有效、完整性。
3.分类：
	主键约束：primary key ---主键是一行数据的唯一标识，要求非空且唯一
    自动增长：auto_increment ---自动增长
    非空约束：not null ---限制该字段的数据不能为null
    唯一约束：unique ---保证该字段的所有数据是唯一的，不重复的
    默认约束：default ---保存数据时，如果未指定该字段的值，则采用默认值
    检查约束：check ---保证字段值满足某一个条件，例如：>0, <=120
    外键约束：foreign key ---用来让两张表的数据之间建立连接，保证数据的一致性和完整性
		1.在创建表的时候就添加：
		create table 表名(
			字段名 数据类型 约束
			...
			
			[constraint][外键名称] foreign key (外键字段名) references 主表(主表列名)
        );
        2.在创建表之后再添加：
        alter table 表名 add constraint 外键名称 foreign key (外键字段名) references 主表(主表列名);
		3.删除外键
        alter table 表名 drop foreign key 外键名称;
        4.删除更新行为
        总语法：
        alter table 表名 add constraint 外键名称 foreign key (外键字段名) references 主表(主表列名) on update xxx on delete xxx;
        no action 当父表中删除/更新对应记录的时候，先检查是否有对应的外键，如果有则不允许删除/更新。
        restrict  当父表中删除/更新对应记录的时候，先检查是否有对应的外键，如果有则不允许删除/更新。
        cascade	  当父表中删除/更新对应记录的时候，先检查是否有对应的外键，如果有则删除/更新外键在子表中的记录。
	    set null  当父表中删除对应记录的时候，首先检查是否有对应的外键，如果有则设置子表中该外键值为null(这就要求该外键运行取null值)。
        set default 当父表变更的时候，子表将外键列设置成一个默认的值。
*/	

/*
-- ---------------------------------------C4S1：创建一个案例，验证约束------------------------------------------
use itcast;
create table ic_user(
	id int primary key auto_increment,
    name varchar(10) not null unique,
    age int check (age > 0 and age <= 120),
	status char(1) default '1',
	gender char(1)
) comment 'User Info';
-- 插入数据 验证primary key and auto_increment
insert into ic_user(name, age, status, gender) values ('Tom1', 19, '1', 'M'),('Tom2', 25, '0', 'M');
insert into ic_user(name, age, status, gender) values ('Tom3', 19, '1', 'M');
-- not null
insert into ic_user(name, age, status, gender) values (null, 19, '1', 'M');
-- unique
insert into ic_user(name, age, status, gender) values ('Tom3', 19, '1', 'M'); #虽然这里由于unique的限制没有插入成功，但是已经向数据库申请了主键，因此下一次插入的数据，会是这次的主键+2
-- check
insert into ic_user(name, age, status, gender) values ('Tom5', -1, '1', 'M');
insert into ic_user(name, age, status, gender) values ('Tom6', 122, '1', 'M');
-- default
insert into ic_user(name, age, gender) values ('Tom6', 120, 'M');
*/

-- ---------------------------------------C4S2：验证外键相关的约束--------------------------------------------------
/*
create table dept(
	id int auto_increment primary key,
	depname varchar(50) not null comment 'department name'
) comment 'department info';
insert into dept(id, depname) values 
	(1, 'research dep'), (2, 'marketing dep'), 
    (3, 'accountancy dep'), (4, 'sales dep'), (5, 'CEO dep');
create table ic_emp(
	id int auto_increment primary key,
	empname varchar(50) not null comment 'employee name',
	age int,
	job varchar(28),
    salary int,
    entrydate date,
    managerid int comment 'diret manager id',
    dept_id int comment'department id foreign key'
) comment 'employee info';
insert into ic_emp (id, empname, age, job, salary, entrydate, managerid, dept_id) values 
	(1, 'JinYong', 66, 'CEO', 20000, '2001-10-09', null, 5),
    (2, 'ZhangWuji', 20, 'project manager', 12500, '2005-12-05', 1, 1),
    (3, 'YangXiao', 33, 'creation', 8400, '2000-11-03', 2, 1),
    (4, 'WeiYixiao', 48, 'creation', 11000, '2002-02-05', 2, 1),
    (5, 'ChangYuchun', 43, 'creation', 10500, '2004-09-07', 3, 1),
    (6, 'XiaoZhao', 19, 'Encourager', 6600, '2004-10-12', 2, 1);
-- 添加外键
alter table ic_emp add constraint fk_icemp_dept_id foreign key (dept_id) references dept(id);
-- 删除外键
alter table ic_emp drop foreign key fk_icemp_dept_id;
-- 外键的删除和更新行为
alter table ic_emp add constraint fk_icemp_dept_id foreign key (dept_id) references dept(id) on update cascade on delete cascade;
-- set null
alter table ic_emp add constraint fk_icemp_dept_id foreign key (dept_id) references dept(id) on update set null on delete cascade;
*/



/*
CHAPTER 5 : 多表查询---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------C5S1：多表关系---------------------------------------
1.多表关系：
	一对多：如部门与员工的关系
		在多的一方建立外键，指向一的一方的主键。
	多对多：如学生和课程
		建立一张中间表，至少包含两个外键，分别关联两方的主键。
    一对一：如用户与用户详情的关系
		在任意一方加入外键，关联另外一方的主键，并且设置外键为unique。这是为了保证避免与一对多混淆，保证一个外键的值不会重复，只能对应一个用户信息。
        一对一的关系多用于单表拆分，将一张表的基础字段放在一张表中，其他的详情字段放在另外一张表中，以提升操作效率。
*/
-- 多对多case演示-----------------------------------------------------------
/*
use itcast;
#建立学生表
create table student(
	id		int				auto_increment primary key,
    name	varchar(10),
    no		varchar(10) comment 'student number'
) comment'student info';
insert into student values 
	(null, 'DaiQisi', '2000100101'),
    (null, 'XieXun', '2000100102'),
    (null, 'YiTiazhe', '2000100103'),
    (null, 'WeiYixiao', '2000100104');
#课程学生表
create table course(
	id		int			auto_increment primary key,
    name	varchar(10)
) comment 'course info';
insert into course values (null, 'Java'), (null, 'PHP'), (null, 'MySQL'), (null, 'Hadoop');
# 建立中间表
create table student_course(
	id			int		auto_increment primary key,
    studentid	int		not null,
    courseid	int		not null,
    constraint fk_courseid foreign key (courseid) references course (id),
    constraint fk_studentid foreign key (studentid) references student (id)
) comment 'student course mid table';
insert into student_course values (null, 1, 1), (null, 1, 2), (null, 1, 3), (null, 2, 2), (null, 2, 3), (null, 3, 4);
*/
-- 一对一case演示-----------------------------------------------------------
/*
create table tbuser(
	id		int				auto_increment primary key,
    name	varchar(10),
    age		int,
    gender	char(1),
    phone	char(11) comment 'phone number'
) comment'tb user basic info';
create table tbuseredu(
	id				int				auto_increment primary key,
    degree			varchar(20),
    major			varchar(50),
    primaryschool	varchar(50),
    middleschool	varchar(50),
    university		varchar(50),
    userid			int unique,
	constraint fk_userid foreign key (userid) references tbuser(id)
) comment 'tb user education info';
insert into tbuser(id, name, age, gender, phone) values 
	(null, 'HuangBo', 45, '1', '18800001111'),
    (null, 'BingBing', 35, '2', '18800002222'),
    (null, 'MaYun', 55, '1', '18800008888'),
    (null, 'LiYanhong', 50, '1', '18800009999');
insert into tbuseredu(id, degree, major, primaryschool, middleschool, university, userid) values 
	(null, 'Bacheler', 'dance', 'JingAnps', 'JingAnms', 'BejingDance', 1),
    (null, 'Master', 'Show', 'ChaoYangps', 'ChaoYangms', 'BejingMovie', 2),
    (null, 'Bacheler', 'English', 'HangZhoups', 'HangZhoums', 'HangZhouTeching', 3),
    (null, 'Bacheler', 'Math', 'YangQvanps', 'YangQvanms', 'QingHua', 4);
*/

/*
----------------------------------------C5S2：多表查询---------------------------------------
从多张表中进行数据的查询
1.连接查询
	内连接：相当于查询A,B交集部分的数据
		隐式内连接：select 字段列表 from 表1，表2 where 条件...;
		显式内连接：select 字段列表 from 表1 [inner] join 表2 on 连接条件...;
    外连接：
		左外连接：查询左表的所有数据，以及两张表的交集的部分数据
			select 字段列表 from 表1 left [outer] join 表2 on 连接条件...;
		右外连接：查询右表的所有数据，以及两张表的交集部分的数据
			select 字段列表 from 表1 right [outer] join 表2 on 连接条件...;
	自连接：当前表与自身的连接查询，自连接必须使用表的别名
		select 字段列表 from 表A 别名A join 表A 别名B on 连接条件...;
	联合查询
		将多次查询的结果合起来形成一个新的查询结果。
			select 字段列表 from 表A ...
			union [all]
			select 字段列表 from 表B ...;
2.子查询
在SQL中嵌套select语句，成为嵌套查询，又称为子查询。
select * from t1 where column1 = (select column1 from t2);
子查询的外部语句可以是insert/update/delete/delect 的任何一个。
	标量子查询(子查询结果为单个值)
		常用的操作符：= <> > >= < <=
    列子查询(子查询结果为一列)
		常用的操作符：in, not in, any, some, all
        in		在指定的集合范围内，多选一
        not in	不在指定的集合范围内
        any		子查询返回列表中，有任意一个满足即可
        some	与any等同，使用some的地方都可以使用any
        all		子查询返回列表的所有值都必须满足
    行子查询(子查询结果为一行)
		常用的操作符：=, <>, in, not in
    表子查询(子查询结果为多行多列)
		常用的操作符：in
        经常出现在from之后，把表子查询的结果作为一个临时表，与其他表进行联查操作。
*/
/*
create table dept(
	id int auto_increment primary key,
	depname varchar(50) not null comment 'department name'
) comment 'department info';
insert into dept(id, depname) values 
	(1, 'research dept'), 
    (2, 'marketing dept'), 
    (3, 'accountancy dept'), 
    (4, 'sales dept'), 
    (5, 'CEO dept'),
    (6, 'labour dept');
create table emp(
	id 			int auto_increment primary key,
	empname 	varchar(50) not null comment 'employee name',
	age 		int,
	job 		varchar(28),
    salary 		int,
    entrydate 	date,
    managerid 	int comment 'diret manager id',
    deptid 		int,
    constraint fk_deptid foreign key (deptid) references dept(id)
) comment 'employee info';
insert into emp (id, empname, age, job, salary, entrydate, managerid, deptid) values 
	(1, 'JinYong', 		66, 'CEO', 					20000, '2001-10-09', null, 5),
    (2, 'ZhangWuji', 	20, 'project manager', 		12500, '2005-12-05', 1, 1),
    (3, 'YangXiao', 	33, 'creation', 			8400, '2000-11-03', 2, 1),
    (4, 'WeiYixiao', 	48, 'creation', 			11000, '2002-02-05', 2, 1),
    (5, 'ChangYuchun', 	43, 'creation', 			10500, '2004-09-07', 3, 1),
    (6, 'XiaoZhao', 	19, 'Encourager', 			6600, '2004-10-12', 2, 1),
    (7, 'MieJue', 		60, 'CFO', 					8500, '2002-09-09', 1, 3),
    (8, 'ZhouZhiruo', 	19, 'accountancy', 			48000, '2006-06-02', 7, 3),
    (9, 'DingMinjun', 	23, 'ChuNa', 				5250, '2009-05-13', 7, 3),
    (10, 'ZhaoMin', 	20, 'Marketing manager', 	12500, '2004-10-05', 1, 2),
    (11, 'LuZhangke', 	56, 'Staff', 				3750, '2006-10-03', 10, 2),
    (12, 'Xiao', 	19, 'Staff', 				3750, '2007-05-09', 10, 2),
    (13, 'Jin', 	19, 'Staff', 				5500, '2009-02-02', 10, 2),
    (14, 'ZgWuji', 	88, 'sales manager', 		14000, '2004-10-12', 1, 4),
    (15, 'Xao', 	38, 'sales', 				4600, '2004-10-12', 14, 4),
    (16, 'WeiYi', 	40, 'sales', 				4600, '2004-10-12', 14, 4),
    (17, 'Changn', 42, null, 					2000, '2011-10-12', 1, null);
-- 多表查询----------------------消除无效的笛卡尔积（子表的外键=父表的主键）
select * from emp, dept where emp.deptid = dept.id;
-- 内连接演示---------------------------------------
#查询每个员工的姓名和关联的部门名称---隐式内连接实现
select emp.empname, dept.depname from emp, dept where emp.deptid = dept.id;
#给表取别名
select e.empname, d.depname from emp e, dept d where e.deptid = d.id;
#查询每个员工的姓名和关联的部门名称---显式内连接实现
select e.empname, d.depname from emp e inner join dept d on e.deptid = d.id; 
#inner可以省略
select e.empname, d.depname from emp e join dept d on e.deptid = d.id; 
-- 外连接演示------------------------------------------------------
#查询emp表的所有数据，和对应的部门信息（左外连接）
select e.*, d.depname from emp e left outer join dept d on e.deptid = d.id;
#查询dept表的所有数据，和对应的员工信息（右外连接）
select d.*, e.* from emp e right outer join dept d on e.deptid = d.id;
##实际开发中，右外用的比较多，因为右外可以被修改成左外
select d.*, e.* from dept d left outer join emp e on e.deptid = d.id;
-- 自连接演示------------------------------------------------------
#查询员工，和所属领导的名字(这里使用内连接)
select a.empname, b.empname from emp a join emp b where a.managerid = b.id;
#查询所有的员工及其领导的名字，如果员工没有领导，也需要查询出来(这里使用外连接)
select a.empname 'staff', b.empname 'leader' from emp a left join emp b on a.managerid = b.id;
-- 联合查询演示------------------------------------------------------
#将薪资低于5000和年龄大于50岁的员工全部查询出来
select * from emp where salary < 5000
union all
select * from emp where age > 50;
#比如，luzhangke由于两个条件都满足，所以出现了两次，如何去重呢：去掉all
select * from emp where salary < 5000
union
select * from emp where age > 50;
-- 标量 子查询演示------------------------------------------------------
#查询销售部的所有员工的信息：
select * from emp where deptid = (select id from dept where depname = 'sales dept');
#查询WeiYixiao入职之后的员工信息
select * from emp where entrydate > (select entrydate from emp where empname = 'WeiYixiao');
-- 列 子查询演示------------------------------------------------------
#查询销售部和市场部的所有员工信息
select * from emp where deptid in (select id from dept where depname = 'sales dept' or depname = 'marketing dept');
#查询比财务部所有人的工资都高的员工信息 #all
select * from emp where salary > all (select salary from emp where deptid = (select id from dept where depname = 'accountancy dept'));
#查询比研发部其中任意一个人工资高的员工信息 #any
select * from emp where salary > any (select salary from emp where deptid = (select id from dept where depname = 'research dept'));
-- 行 子查询演示------------------------------------------------------
#查询张无忌的薪资及其直属领导相同的员工信息
select * from emp where (salary, managerid) = (select salary, managerid from emp where empname = 'ZhangWuji');
-- 表 子查询演示------------------------------------------------------
#查询luzhagnke和yangxiao的职位和薪资相同的员工信息
select * from emp where (job, salary) in (select job, salary from emp where empname = 'LuZhangke' or 'YangXiao');
#查询入职日期是2006-01-01之后的员工信息及其部门信息
select e.*, d.* from (select * from emp where entrydate > '2006-01-01') e left join dept d on e.deptid = d.id;
*/



/*
CHAPTER 6 : 存储过程---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------C6S1：存储过程 基本语法---------------------------------------
存储过程：封装，是事先经过编译并且存储在数据库中的一段SQL语句的集合，直接调用就行。
1.特点：封装，复用；可以接受参数并且返回数据；减少网络交互，效率提升。
2.创建一个存储过程：
	create procedure 存储过程的名称([参数列表])
    begin
		--SQL syntex
	end;
3.invoke stored procedure:
	call name([parameters]);
4.View stored procedure:
	select * from information_schema.routines where routine_schema = 'xxx'; --查询数据库的存储过程及状态信息
	show create procedure 存储过程名称; --查询某个存储过程的定义
5.delete stored procedure:
	drop procedure [if exists] 存储过程的名称;

*/
/*
##统计emp的总记录数
-- 创建
delimiter $$
create procedure p1()
begin
	select count(*) from emp;
end$$
delimiter ;
-- 调用
call p1();
-- 查看
select * from information_schema.routines where routine_schema = 'itcast';
show create procedure p1;
-- 删除
drop procedure if exists p1;
*/

/*
----------------------------------------C6S2：存储过程 变量---------------------------------------
1.系统变量
	全局变量global    会话变量session
    view system variable:
		show [session|global] variables;
        show [session|global] variables like '......';
        select @@[session|global] 系统变量名
    set system variable:
		set [session|global] 系统变量名=值;
        set @@[session|global] 系统变量名=值;

    
2.用户定义变量



3.局部变量


*/

-- variable: system variables
-- view system variables
	show variables;						#variables前面没加级别，便默认为会话级别的系统变量
	show session variables like 'init%';#一定要加%，用于模糊匹配
	show global variables like 'init%';
	select @@autocommit;				#准确查看某个系统变量的值 #variables前面没加级别，便默认为会话级别的系统变量
	select @@global.autocommit; 
	select @@session.autocommit; 
-- set system variable:
	set session autocommit = 0; #设置为0表示将这个变量给关掉，后续执行insert into的操作，就不能够自动化更新，即自动提交关闭；需要使用“commit;”来进行手动提交。
	set session autocommit = 1; #这样就把参数打开了，就可以自动更新了。
    set global autocommit = 0;
    select @@global.autocommit; #虽然设置了全局的，但是当服务器重启之后，又会恢复到初始值。如果希望永久修改变量，可以在/etc/my.cnf中配置。
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    