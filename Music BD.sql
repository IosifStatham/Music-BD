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

insert into Genre_of_music(name_of_genre) values
 ('пост-панк'),
 ('Хип-Хоп'),
 ('прогрессив-хаус'),
 ('рок');

insert into Musical_group(name) values 
 ('Улица восток'),
 ('Burito'),
 ('Alan Walker'),
 ('The Rasmus');

insert into GroupGenre (musicalgroupid, genreofmusicid) values
 (1, 1),
 (2, 2),
 (3, 3),
 (4, 4);

insert into albom (albomtitle, yearofalbom) values
('Запомню', '2021'),
('Она', '2022'),
('Catch Me If You Can', '2022'),
('Catch Me If You Can2', '2020'),
('Livin in a World Without You', '2008');

insert into GroupAlbom (albomid, groupid) values
 (1, 1),
 (2, 2),
 (3, 3),
 (12, 2),
 (4, 4);
 
insert into music (title, albom, duration) values
('Запомню', 1, 183),
('Она', 2, 196),
('Catch Me If You Can', 3, 151),
('Livin in a World Without You', 4, 230),
('You Got It Wrong', 4, 195),
('Livin in a World Without You (extended)', 4, 250);

insert into Compilation (namecompilation, yearcompilation) values 
('В дорогу', 2022),
('В долгую дорогу', 2023),
('Под настроение', 2023),
('По одному треку из каждого альбома', 2023);

insert into compilationmusic (titlemusic, compilation) values 
(3 , 1),
(4 , 1),
(5 , 1),
(6 , 2),
(1 , 3),
(2 , 3),
(1 , 4),
(2 , 4),
(3 , 4),
(4 , 4);

select title, duration from music
where duration = (select max(duration) from music);

select title, duration from music
where duration >= 210;

select namecompilation, yearcompilation from compilation
where yearcompilation between 2018 and 2020;

select name from musical_group
where name not like '% %';

select distinct title from music
where title ILIKE 'мой %' 
or title ILIKE '% мой' 
or title ILIKE '% мой %' 
or title ILIKE 'мой'
or title ILIKE '% my' 
or title ILIKE '% my %' 
or title ILIKE 'my'
or title ILIKE 'my %';

select genreofmusicid, count(musicalgroupid) from groupgenre
group by genreofmusicid
order by count(musicalgroupid) desc;

select count(title) from music
join albom on music.albom = albom.idalbom
where yearofalbom between 2018 and 2020;

select avg(duration), albom from music
group by albom;

select name, albomtitle, yearofalbom from musical_group
join groupalbom on groupalbom.groupid = musical_group.groupid
join albom on groupalbom.albomid = albom.idalbom
where not yearofalbom = 2020;

select name from musical_group
where groupid not in (
select groupid from groupalbom
join albom on groupalbom.albomid = albom.idalbom
where yearofalbom = 2020);

select namecompilation, name from compilation
join compilationmusic on compilationmusic.compilation = compilation.idcompilation 
join music on compilationmusic.titlemusic = music.idmusic 
join albom on music.albom = albom.idalbom 
join groupalbom on groupalbom.albomid  = albom.idalbom 
join musical_group on groupalbom.groupid  = musical_group.groupid
where name = 'Alan Walker';


