
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/29/2017 17:33:38
-- Generated from EDMX file: D:\Desarrollo\Mios\Habilitacion profecional\HabProf\WebApplication1\Aplicativo\HabProfDB.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [HabProfDB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_PersonaTesista]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesistas] DROP CONSTRAINT [FK_PersonaTesista];
GO
IF OBJECT_ID(N'[dbo].[FK_PersonaDirector]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Directores] DROP CONSTRAINT [FK_PersonaDirector];
GO
IF OBJECT_ID(N'[dbo].[FK_PersonaJuez]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Jueces] DROP CONSTRAINT [FK_PersonaJuez];
GO
IF OBJECT_ID(N'[dbo].[FK_PersonaAdministrador]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Administradores] DROP CONSTRAINT [FK_PersonaAdministrador];
GO
IF OBJECT_ID(N'[dbo].[FK_TesistaTesis]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesistas] DROP CONSTRAINT [FK_TesistaTesis];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorTesista]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesistas] DROP CONSTRAINT [FK_DirectorTesista];
GO
IF OBJECT_ID(N'[dbo].[FK_LicenciaturaAdministrador]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Administradores] DROP CONSTRAINT [FK_LicenciaturaAdministrador];
GO
IF OBJECT_ID(N'[dbo].[FK_Estado_tesisTesis]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesinas] DROP CONSTRAINT [FK_Estado_tesisTesis];
GO
IF OBJECT_ID(N'[dbo].[FK_TesisHistorial_estado]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Historial_estados] DROP CONSTRAINT [FK_TesisHistorial_estado];
GO
IF OBJECT_ID(N'[dbo].[FK_Estado_tesisHistorial_estado]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Historial_estados] DROP CONSTRAINT [FK_Estado_tesisHistorial_estado];
GO
IF OBJECT_ID(N'[dbo].[FK_ServidorLicenciatura]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Licenciaturas] DROP CONSTRAINT [FK_ServidorLicenciatura];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Personas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas];
GO
IF OBJECT_ID(N'[dbo].[Tesistas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tesistas];
GO
IF OBJECT_ID(N'[dbo].[Directores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Directores];
GO
IF OBJECT_ID(N'[dbo].[Administradores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Administradores];
GO
IF OBJECT_ID(N'[dbo].[Jueces]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Jueces];
GO
IF OBJECT_ID(N'[dbo].[Tesinas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tesinas];
GO
IF OBJECT_ID(N'[dbo].[Licenciaturas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Licenciaturas];
GO
IF OBJECT_ID(N'[dbo].[Estados_tesis]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Estados_tesis];
GO
IF OBJECT_ID(N'[dbo].[Historial_estados]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Historial_estados];
GO
IF OBJECT_ID(N'[dbo].[Servidores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Servidores];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Personas'
CREATE TABLE [dbo].[Personas] (
    [persona_id] int IDENTITY(1,1) NOT NULL,
    [persona_nomyap] nvarchar(max)  NOT NULL,
    [persona_dni] nvarchar(max)  NOT NULL,
    [persona_email] nvarchar(max)  NOT NULL,
    [persona_domicilio] nvarchar(max)  NOT NULL,
    [persona_telefono] nvarchar(max)  NOT NULL,
    [licenciatura_id] int  NOT NULL
);
GO

-- Creating table 'Tesistas'
CREATE TABLE [dbo].[Tesistas] (
    [tesista_id] int IDENTITY(1,1) NOT NULL,
    [tesista_legajo] nvarchar(max)  NOT NULL,
    [tesista_sede] nvarchar(max)  NOT NULL,
    [director_id] int  NOT NULL,
    [Persona_persona_id] int  NOT NULL,
    [Tesis_tesis_id] int  NOT NULL
);
GO

-- Creating table 'Directores'
CREATE TABLE [dbo].[Directores] (
    [director_id] int IDENTITY(1,1) NOT NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Administradores'
CREATE TABLE [dbo].[Administradores] (
    [administrador_id] int IDENTITY(1,1) NOT NULL,
    [administrador_usuario] nvarchar(max)  NOT NULL,
    [administrador_clave] nvarchar(max)  NOT NULL,
    [administrador_estilo] nvarchar(max)  NOT NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Jueces'
CREATE TABLE [dbo].[Jueces] (
    [juez_id] int IDENTITY(1,1) NOT NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Tesinas'
CREATE TABLE [dbo].[Tesinas] (
    [tesis_id] int IDENTITY(1,1) NOT NULL,
    [estado_tesis_id] int  NOT NULL,
    [tesis_tema] nvarchar(max)  NOT NULL,
    [tesis_palabras_clave] nvarchar(max)  NOT NULL,
    [tesis_borrador] nvarchar(max)  NOT NULL,
    [tesis_plan_fch_presentacion] datetime  NOT NULL,
    [tesis_plan_duracion_anios] smallint  NOT NULL,
    [tesis_plan_aviso_meses] smallint  NOT NULL
);
GO

-- Creating table 'Licenciaturas'
CREATE TABLE [dbo].[Licenciaturas] (
    [licenciatura_id] int IDENTITY(1,1) NOT NULL,
    [licenciatura_nombre] nvarchar(max)  NOT NULL,
    [licenciatura_descripcion] nvarchar(max)  NOT NULL,
    [licenciatura_email] nvarchar(max)  NOT NULL,
    [licenciatura_clave] nvarchar(max)  NOT NULL,
    [servidor_id] int  NOT NULL
);
GO

-- Creating table 'Estados_tesis'
CREATE TABLE [dbo].[Estados_tesis] (
    [estado_tesis_id] int IDENTITY(1,1) NOT NULL,
    [estado_estado] nvarchar(max)  NOT NULL,
    [estado_descripcion] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Historial_estados'
CREATE TABLE [dbo].[Historial_estados] (
    [historial_id] int IDENTITY(1,1) NOT NULL,
    [tesis_id] int  NOT NULL,
    [estado_tesis_id] int  NOT NULL,
    [historial_descripcion] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Servidores'
CREATE TABLE [dbo].[Servidores] (
    [servidor_id] int IDENTITY(1,1) NOT NULL,
    [servidor_nombre] nvarchar(max)  NOT NULL,
    [servidor_smtp_host] nvarchar(max)  NOT NULL,
    [servidor_smtp_port] smallint  NOT NULL,
    [servidor_enable_ssl] bit  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [persona_id] in table 'Personas'
ALTER TABLE [dbo].[Personas]
ADD CONSTRAINT [PK_Personas]
    PRIMARY KEY CLUSTERED ([persona_id] ASC);
GO

-- Creating primary key on [tesista_id] in table 'Tesistas'
ALTER TABLE [dbo].[Tesistas]
ADD CONSTRAINT [PK_Tesistas]
    PRIMARY KEY CLUSTERED ([tesista_id] ASC);
GO

-- Creating primary key on [director_id] in table 'Directores'
ALTER TABLE [dbo].[Directores]
ADD CONSTRAINT [PK_Directores]
    PRIMARY KEY CLUSTERED ([director_id] ASC);
GO

-- Creating primary key on [administrador_id] in table 'Administradores'
ALTER TABLE [dbo].[Administradores]
ADD CONSTRAINT [PK_Administradores]
    PRIMARY KEY CLUSTERED ([administrador_id] ASC);
GO

-- Creating primary key on [juez_id] in table 'Jueces'
ALTER TABLE [dbo].[Jueces]
ADD CONSTRAINT [PK_Jueces]
    PRIMARY KEY CLUSTERED ([juez_id] ASC);
GO

-- Creating primary key on [tesis_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [PK_Tesinas]
    PRIMARY KEY CLUSTERED ([tesis_id] ASC);
GO

-- Creating primary key on [licenciatura_id] in table 'Licenciaturas'
ALTER TABLE [dbo].[Licenciaturas]
ADD CONSTRAINT [PK_Licenciaturas]
    PRIMARY KEY CLUSTERED ([licenciatura_id] ASC);
GO

-- Creating primary key on [estado_tesis_id] in table 'Estados_tesis'
ALTER TABLE [dbo].[Estados_tesis]
ADD CONSTRAINT [PK_Estados_tesis]
    PRIMARY KEY CLUSTERED ([estado_tesis_id] ASC);
GO

-- Creating primary key on [historial_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [PK_Historial_estados]
    PRIMARY KEY CLUSTERED ([historial_id] ASC);
GO

-- Creating primary key on [servidor_id] in table 'Servidores'
ALTER TABLE [dbo].[Servidores]
ADD CONSTRAINT [PK_Servidores]
    PRIMARY KEY CLUSTERED ([servidor_id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Persona_persona_id] in table 'Tesistas'
ALTER TABLE [dbo].[Tesistas]
ADD CONSTRAINT [FK_PersonaTesista]
    FOREIGN KEY ([Persona_persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonaTesista'
CREATE INDEX [IX_FK_PersonaTesista]
ON [dbo].[Tesistas]
    ([Persona_persona_id]);
GO

-- Creating foreign key on [Persona_persona_id] in table 'Directores'
ALTER TABLE [dbo].[Directores]
ADD CONSTRAINT [FK_PersonaDirector]
    FOREIGN KEY ([Persona_persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonaDirector'
CREATE INDEX [IX_FK_PersonaDirector]
ON [dbo].[Directores]
    ([Persona_persona_id]);
GO

-- Creating foreign key on [Persona_persona_id] in table 'Jueces'
ALTER TABLE [dbo].[Jueces]
ADD CONSTRAINT [FK_PersonaJuez]
    FOREIGN KEY ([Persona_persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonaJuez'
CREATE INDEX [IX_FK_PersonaJuez]
ON [dbo].[Jueces]
    ([Persona_persona_id]);
GO

-- Creating foreign key on [Persona_persona_id] in table 'Administradores'
ALTER TABLE [dbo].[Administradores]
ADD CONSTRAINT [FK_PersonaAdministrador]
    FOREIGN KEY ([Persona_persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonaAdministrador'
CREATE INDEX [IX_FK_PersonaAdministrador]
ON [dbo].[Administradores]
    ([Persona_persona_id]);
GO

-- Creating foreign key on [Tesis_tesis_id] in table 'Tesistas'
ALTER TABLE [dbo].[Tesistas]
ADD CONSTRAINT [FK_TesistaTesis]
    FOREIGN KEY ([Tesis_tesis_id])
    REFERENCES [dbo].[Tesinas]
        ([tesis_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TesistaTesis'
CREATE INDEX [IX_FK_TesistaTesis]
ON [dbo].[Tesistas]
    ([Tesis_tesis_id]);
GO

-- Creating foreign key on [director_id] in table 'Tesistas'
ALTER TABLE [dbo].[Tesistas]
ADD CONSTRAINT [FK_DirectorTesista]
    FOREIGN KEY ([director_id])
    REFERENCES [dbo].[Directores]
        ([director_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorTesista'
CREATE INDEX [IX_FK_DirectorTesista]
ON [dbo].[Tesistas]
    ([director_id]);
GO

-- Creating foreign key on [estado_tesis_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_Estado_tesisTesis]
    FOREIGN KEY ([estado_tesis_id])
    REFERENCES [dbo].[Estados_tesis]
        ([estado_tesis_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Estado_tesisTesis'
CREATE INDEX [IX_FK_Estado_tesisTesis]
ON [dbo].[Tesinas]
    ([estado_tesis_id]);
GO

-- Creating foreign key on [tesis_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [FK_TesisHistorial_estado]
    FOREIGN KEY ([tesis_id])
    REFERENCES [dbo].[Tesinas]
        ([tesis_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TesisHistorial_estado'
CREATE INDEX [IX_FK_TesisHistorial_estado]
ON [dbo].[Historial_estados]
    ([tesis_id]);
GO

-- Creating foreign key on [estado_tesis_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [FK_Estado_tesisHistorial_estado]
    FOREIGN KEY ([estado_tesis_id])
    REFERENCES [dbo].[Estados_tesis]
        ([estado_tesis_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Estado_tesisHistorial_estado'
CREATE INDEX [IX_FK_Estado_tesisHistorial_estado]
ON [dbo].[Historial_estados]
    ([estado_tesis_id]);
GO

-- Creating foreign key on [servidor_id] in table 'Licenciaturas'
ALTER TABLE [dbo].[Licenciaturas]
ADD CONSTRAINT [FK_ServidorLicenciatura]
    FOREIGN KEY ([servidor_id])
    REFERENCES [dbo].[Servidores]
        ([servidor_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ServidorLicenciatura'
CREATE INDEX [IX_FK_ServidorLicenciatura]
ON [dbo].[Licenciaturas]
    ([servidor_id]);
GO

-- Creating foreign key on [licenciatura_id] in table 'Personas'
ALTER TABLE [dbo].[Personas]
ADD CONSTRAINT [FK_LicenciaturaPersona]
    FOREIGN KEY ([licenciatura_id])
    REFERENCES [dbo].[Licenciaturas]
        ([licenciatura_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LicenciaturaPersona'
CREATE INDEX [IX_FK_LicenciaturaPersona]
ON [dbo].[Personas]
    ([licenciatura_id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------