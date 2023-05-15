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
Albom VARCHAR (30) not null references Albom(IDAlbom),
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