create table if not exists Genre_of_music (
GenreID SERIAL primary key,
Name VARCHAR (20) unique not null
);

create table if not exists Musical_group (
GroupID SERIAL primary key,
Name VARCHAR (20) unique not null
);

create table if not exists GroupGenre (
ID SERIAL primary key,
MusicalGroupID INTEGER references Musical_group(GroupID),
GenreOfMusicID INTEGER references Genre_of_music(GenreID)
);

create table if not exists Albom (
IDAlbom SERIAL primary key,
AlbomTitle VARCHAR (30) not null,
YearOfAlbom INTEGER not null check (YearOfAlbom < 2024)
);

create table if not exists GroupAlbom (
id SERIAL primary key,
albomID INTEGER references Albom(IDAlbom),
groupID INTEGER references Musical_group(GroupID)
);

create table if not exists Music (
IDMusic SERIAL primary key,
Title VARCHAR (50) not null,
Albom INTEGER references Albom(IDAlbom),
Duration INTEGER not null check (Duration < 601)
);

create table if not exists Compilation (
IDCompilation SERIAL primary key,
NameCompilation VARCHAR (50) not null unique,
yearCompilation INTEGER not null check (yearCompilation < 2024)
);

create table if not exists CompilationMusic (
ID SERIAL primary key,
titleMusic INTEGER references Music(IDMusic),
compilation INTEGER references Compilation(IDCompilation)
);

insert into Genre_of_music(name_of_genre)
values ('пост-панк');
insert into Musical_group(name)
values ('Улица восток');
insert into GroupGenre (musicalgroupid, genreofmusicid)
values (1, 1);

insert into Genre_of_music(name_of_genre)
values ('Хип-Хоп');
insert into Musical_group(name)
values ('Burito');
insert into GroupGenre (musicalgroupid, genreofmusicid)
values (2, 2);

insert into Genre_of_music(name_of_genre)
values ('прогрессив-хаус');
insert into Musical_group(name)
values ('Alan Walker');
insert into GroupGenre (musicalgroupid, genreofmusicid)
values (3, 3);

insert into Genre_of_music(name_of_genre)
values ('рок');
insert into Musical_group(name)
values ('The Rasmus');
insert into GroupGenre (musicalgroupid, genreofmusicid)
values (4, 4);


insert into albom (albomtitle, yearofalbom)
values ('Запомню', '2021');

insert into albom (albomtitle, yearofalbom)
values ('Она', '2022');

insert into albom (albomtitle, yearofalbom)
values ('Catch Me If You Can', '2022');

insert into albom (albomtitle, yearofalbom)
values ('Livin in a World Without You', '2008');



insert into GroupAlbom (albomid, groupid)
values (1, 1);

insert into GroupAlbom (albomid, groupid)
values (2, 2);

insert into GroupAlbom (albomid, groupid)
values (3, 3);

insert into GroupAlbom (albomid, groupid)
values (4, 4);


insert into music (title, albom, duration)
values ('Запомню', 1, 183);

insert into music (title, albom, duration)
values ('Она', 2, 196);

insert into music (title, albom, duration)
values ('Catch Me If You Can', 3, 151);

insert into music (title, albom, duration)
values ('Livin in a World Without You', 4, 230);
insert into music (title, albom, duration)
values ('You Got It Wrong', 4, 195);
insert into music (title, albom, duration)
values ('Livin in a World Without You (extended)', 4, 250);

insert into Compilation (namecompilation, yearcompilation)
values ('В дорогу', 2022);

insert into Compilation (namecompilation, yearcompilation)
values ('В долгую дорогу', 2023);

insert into Compilation (namecompilation, yearcompilation)
values ('Под настроение', 2023);

insert into Compilation (namecompilation, yearcompilation)
values ('По одному треку из каждого альбома', 2023);

insert into compilationmusic (titlemusic, compilation)
values (3 , 1);
insert into compilationmusic (titlemusic, compilation)
values (4 , 1);
insert into compilationmusic (titlemusic, compilation)
values (5 , 1);

insert into compilationmusic (titlemusic, compilation)
values (6 , 2);

insert into compilationmusic (titlemusic, compilation)
values (1 , 3);
insert into compilationmusic (titlemusic, compilation)
values (2 , 3);

insert into compilationmusic (titlemusic, compilation)
values (1 , 4);
insert into compilationmusic (titlemusic, compilation)
values (2 , 4);
insert into compilationmusic (titlemusic, compilation)
values (3 , 4);
insert into compilationmusic (titlemusic, compilation)
values (4 , 4);

select title, duration from music
order by duration desc limit 1;

select title, duration from music
where duration >= 210;

select namecompilation, yearcompilation from compilation
where yearcompilation between 2018 and 2020;

select name from musical_group
where name not like '% %';

select title from music
where title like '%мой%' or title like '%my%';

select genreofmusicid, count(musicalgroupid) from groupgenre
group by genreofmusicid
order by count(musicalgroupid) desc;

select count(title), yearofalbom from music
join albom on music.albom = albom.idalbom
where yearofalbom between 2018 and 2020
group by yearofalbom;

select avg(duration), albom from music
group by albom;

select name, albomtitle, yearofalbom from musical_group
join groupalbom on groupalbom.groupid = musical_group.groupid
join albom on groupalbom.albomid = albom.idalbom
where not yearofalbom = 2020;

select namecompilation, name from compilation
join compilationmusic on compilationmusic.compilation = compilation.idcompilation 
join music on compilationmusic.titlemusic = music.idmusic 
join albom on music.albom = albom.idalbom 
join groupalbom on groupalbom.albomid  = albom.idalbom 
join musical_group on groupalbom.groupid  = musical_group.groupid
where name = 'Alan Walker';