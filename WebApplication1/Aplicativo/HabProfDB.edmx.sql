
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 01/05/2018 21:44:56
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
IF OBJECT_ID(N'[dbo].[FK_LicenciaturaPersona]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personas] DROP CONSTRAINT [FK_LicenciaturaPersona];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorTesis]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesinas] DROP CONSTRAINT [FK_DirectorTesis];
GO
IF OBJECT_ID(N'[dbo].[FK_TesistaTesis]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesinas] DROP CONSTRAINT [FK_TesistaTesis];
GO
IF OBJECT_ID(N'[dbo].[FK_Director_inherits_Persona]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personas_Director] DROP CONSTRAINT [FK_Director_inherits_Persona];
GO
IF OBJECT_ID(N'[dbo].[FK_Tesista_inherits_Persona]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personas_Tesista] DROP CONSTRAINT [FK_Tesista_inherits_Persona];
GO
IF OBJECT_ID(N'[dbo].[FK_Administrador_inherits_Persona]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personas_Administrador] DROP CONSTRAINT [FK_Administrador_inherits_Persona];
GO
IF OBJECT_ID(N'[dbo].[FK_Juez_inherits_Persona]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personas_Juez] DROP CONSTRAINT [FK_Juez_inherits_Persona];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Personas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas];
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
IF OBJECT_ID(N'[dbo].[Personas_Director]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas_Director];
GO
IF OBJECT_ID(N'[dbo].[Personas_Tesista]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas_Tesista];
GO
IF OBJECT_ID(N'[dbo].[Personas_Administrador]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas_Administrador];
GO
IF OBJECT_ID(N'[dbo].[Personas_Juez]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personas_Juez];
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
    [licenciatura_id] int  NOT NULL,
    [persona_usuario] nvarchar(max)  NOT NULL,
    [persona_clave] nvarchar(max)  NOT NULL,
    [persona_estilo] nvarchar(max)  NOT NULL,
    [persona_fecha_baja] datetime  NULL
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
    [tesis_plan_duracion_meses] smallint  NOT NULL,
    [tesis_plan_aviso_meses] smallint  NOT NULL,
    [director_persona_id] int  NOT NULL,
    [tesista_persona_id] int  NOT NULL,
    [tesis_calificacion] smallint  NOT NULL,
    [tesis_fecha_cierre] datetime  NOT NULL
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

-- Creating table 'Personas_Director'
CREATE TABLE [dbo].[Personas_Director] (
    [director_calificacion] decimal(4,2)  NOT NULL,
    [persona_id] int  NOT NULL
);
GO

-- Creating table 'Personas_Tesista'
CREATE TABLE [dbo].[Personas_Tesista] (
    [tesista_legajo] nvarchar(max)  NOT NULL,
    [tesista_sede] nvarchar(max)  NOT NULL,
    [persona_id] int  NOT NULL
);
GO

-- Creating table 'Personas_Administrador'
CREATE TABLE [dbo].[Personas_Administrador] (
    [persona_id] int  NOT NULL
);
GO

-- Creating table 'Personas_Juez'
CREATE TABLE [dbo].[Personas_Juez] (
    [persona_id] int  NOT NULL
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

-- Creating primary key on [persona_id] in table 'Personas_Director'
ALTER TABLE [dbo].[Personas_Director]
ADD CONSTRAINT [PK_Personas_Director]
    PRIMARY KEY CLUSTERED ([persona_id] ASC);
GO

-- Creating primary key on [persona_id] in table 'Personas_Tesista'
ALTER TABLE [dbo].[Personas_Tesista]
ADD CONSTRAINT [PK_Personas_Tesista]
    PRIMARY KEY CLUSTERED ([persona_id] ASC);
GO

-- Creating primary key on [persona_id] in table 'Personas_Administrador'
ALTER TABLE [dbo].[Personas_Administrador]
ADD CONSTRAINT [PK_Personas_Administrador]
    PRIMARY KEY CLUSTERED ([persona_id] ASC);
GO

-- Creating primary key on [persona_id] in table 'Personas_Juez'
ALTER TABLE [dbo].[Personas_Juez]
ADD CONSTRAINT [PK_Personas_Juez]
    PRIMARY KEY CLUSTERED ([persona_id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

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

-- Creating foreign key on [director_persona_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_DirectorTesis]
    FOREIGN KEY ([director_persona_id])
    REFERENCES [dbo].[Personas_Director]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorTesis'
CREATE INDEX [IX_FK_DirectorTesis]
ON [dbo].[Tesinas]
    ([director_persona_id]);
GO

-- Creating foreign key on [tesista_persona_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_TesistaTesis]
    FOREIGN KEY ([tesista_persona_id])
    REFERENCES [dbo].[Personas_Tesista]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TesistaTesis'
CREATE INDEX [IX_FK_TesistaTesis]
ON [dbo].[Tesinas]
    ([tesista_persona_id]);
GO

-- Creating foreign key on [persona_id] in table 'Personas_Director'
ALTER TABLE [dbo].[Personas_Director]
ADD CONSTRAINT [FK_Director_inherits_Persona]
    FOREIGN KEY ([persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [persona_id] in table 'Personas_Tesista'
ALTER TABLE [dbo].[Personas_Tesista]
ADD CONSTRAINT [FK_Tesista_inherits_Persona]
    FOREIGN KEY ([persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [persona_id] in table 'Personas_Administrador'
ALTER TABLE [dbo].[Personas_Administrador]
ADD CONSTRAINT [FK_Administrador_inherits_Persona]
    FOREIGN KEY ([persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- Creating foreign key on [persona_id] in table 'Personas_Juez'
ALTER TABLE [dbo].[Personas_Juez]
ADD CONSTRAINT [FK_Juez_inherits_Persona]
    FOREIGN KEY ([persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------