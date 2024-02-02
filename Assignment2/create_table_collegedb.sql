create table student(
	sid int not null primary key,
	sname varchar(40),
	gender varchar(1),
	gpa float(16)
);

create table department(
	dname varchar(40) not null primary key,
	numphds int
);

create table professor(
	pname varchar(40) not null primary key,
	dname varchar(40) not null REFERENCES department(dname)
);

create table course(
	cno int not null,
	cname varchar(40),
	dname varchar(40) not null REFERENCES department(dname),
	primary key(cno, dname)
);

create table major(
	dname varchar(40) not null references department(dname),
	sid int references student(sid),
	primary key(dname, sid)
);

create table enroll(
	sid int references student(sid),
	grade float(16),
	dname varchar(40),
	cno int,
	constraint pkey foreign key(cno, dname) references course(cno, dname),
	primary key(sid, dname, cno)
);