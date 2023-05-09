create table if not exists Genre_of_music (
Genre SERIAL primary key,
Name VARCHAR (20) unique not null
);

create table if not exists Musical_group (
GroupID SERIAL primary key,
Name VARCHAR (20) unique not null
);

create table if not exists GroupGenre (
id serial primary key,
MusicalGroupID integer references Musical_group(GroupID),
GenreOfMusicID integer references Genre_of_music(Genre)
);

create table if not exists Albom (
AlbomTitle VARCHAR (30) not null primary key,
YearOfAlbom integer not null
);

create table if not exists GroupAlbom (
id serial primary key,
albom VARCHAR (30) references Albom(AlbomTitle),
groupID integer references Musical_group(GroupID)
);

create table if not exists Music (
Title VARCHAR (50) not null primary key,
Albom VARCHAR (30) not null references Albom(AlbomTitle),
Duration NUMERIC not null
);

create table if not exists Compilation (
NameCompilation VARCHAR (50) not null unique primary key,
yearCompilation integer not null
);

create table if not exists CompilationMusic (
ID SERIAL primary key,
titleMusic VARCHAR (50) references Music(Title),
compilation VARCHAR (50) references Compilation(NameCompilation)
);
