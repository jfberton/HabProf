
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 01/31/2018 18:35:11
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
IF OBJECT_ID(N'[dbo].[FK_PersonaEnvio_mail]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Envio_mails] DROP CONSTRAINT [FK_PersonaEnvio_mail];
GO
IF OBJECT_ID(N'[dbo].[FK_TesistaTesina]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesinas] DROP CONSTRAINT [FK_TesistaTesina];
GO
IF OBJECT_ID(N'[dbo].[FK_DirectorTesina]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tesinas] DROP CONSTRAINT [FK_DirectorTesina];
GO
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
IF OBJECT_ID(N'[dbo].[FK_JuezTesina_Juez]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[JuezTesina] DROP CONSTRAINT [FK_JuezTesina_Juez];
GO
IF OBJECT_ID(N'[dbo].[FK_JuezTesina_Tesina]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[JuezTesina] DROP CONSTRAINT [FK_JuezTesina_Tesina];
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
IF OBJECT_ID(N'[dbo].[Estados_tesinas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Estados_tesinas];
GO
IF OBJECT_ID(N'[dbo].[Historial_estados]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Historial_estados];
GO
IF OBJECT_ID(N'[dbo].[Servidores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Servidores];
GO
IF OBJECT_ID(N'[dbo].[Envio_mails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Envio_mails];
GO
IF OBJECT_ID(N'[dbo].[Jueces]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Jueces];
GO
IF OBJECT_ID(N'[dbo].[Administradores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Administradores];
GO
IF OBJECT_ID(N'[dbo].[Directores]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Directores];
GO
IF OBJECT_ID(N'[dbo].[Tesistas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tesistas];
GO
IF OBJECT_ID(N'[dbo].[JuezTesina]', 'U') IS NOT NULL
    DROP TABLE [dbo].[JuezTesina];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Personas'
CREATE TABLE [dbo].[Personas] (
    [persona_id] int IDENTITY(1,1) NOT NULL,
    [persona_nomyap] nvarchar(max)  NOT NULL,
    [persona_dni] int  NOT NULL,
    [persona_email] nvarchar(max)  NOT NULL,
    [persona_email_validado] bit  NOT NULL,
    [persona_domicilio] nvarchar(max)  NOT NULL,
    [persona_telefono] nvarchar(max)  NOT NULL,
    [licenciatura_id] int  NOT NULL,
    [persona_usuario] nvarchar(max)  NOT NULL,
    [persona_clave] nvarchar(max)  NOT NULL,
    [persona_estilo] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Tesinas'
CREATE TABLE [dbo].[Tesinas] (
    [tesina_id] int IDENTITY(1,1) NOT NULL,
    [estado_tesis_id] int  NOT NULL,
    [tesina_tema] nvarchar(max)  NOT NULL,
    [tesina_descripcion] nvarchar(max)  NOT NULL,
    [tesina_borrador] nvarchar(max)  NULL,
    [tesina_plan_fch_presentacion] datetime  NOT NULL,
    [tesina_plan_duracion_meses] smallint  NOT NULL,
    [tesina_plan_aviso_meses] smallint  NOT NULL,
    [tesina_calificacion] smallint  NULL,
    [tesina_fecha_cierre] datetime  NULL,
    [tesina_calificacion_director] smallint  NULL,
    [tesista_id] int  NOT NULL,
    [director_id] int  NOT NULL
);
GO

-- Creating table 'Licenciaturas'
CREATE TABLE [dbo].[Licenciaturas] (
    [licenciatura_id] int IDENTITY(1,1) NOT NULL,
    [licenciatura_nombre] nvarchar(max)  NOT NULL,
    [licenciatura_descripcion] nvarchar(max)  NOT NULL,
    [licenciatura_email] nvarchar(max)  NOT NULL,
    [licenciatura_email_clave] nvarchar(max)  NOT NULL,
    [servidor_id] int  NOT NULL
);
GO

-- Creating table 'Estados_tesinas'
CREATE TABLE [dbo].[Estados_tesinas] (
    [estado_tesina_id] int IDENTITY(1,1) NOT NULL,
    [estado_tesina_estado] nvarchar(max)  NOT NULL,
    [estado_tesina_descripcion] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Historial_estados'
CREATE TABLE [dbo].[Historial_estados] (
    [historial_tesina_id] int IDENTITY(1,1) NOT NULL,
    [tesina_id] int  NOT NULL,
    [estado_tesina_id] int  NOT NULL,
    [historial_tesina_descripcion] nvarchar(max)  NOT NULL,
    [historial_tesina_fecha] datetime  NOT NULL
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

-- Creating table 'Envio_mails'
CREATE TABLE [dbo].[Envio_mails] (
    [envio_id] int IDENTITY(1,1) NOT NULL,
    [persona_id] int  NOT NULL,
    [envio_fecha_hora] datetime  NOT NULL,
    [envio_tipo] nvarchar(max)  NOT NULL,
    [envio_email_destino] nvarchar(max)  NOT NULL,
    [envio_respuesta_clave] nvarchar(max)  NOT NULL,
    [envio_respuesta_recibida] datetime  NULL,
    [tipo_mail_id] int  NOT NULL
);
GO

-- Creating table 'Jueces'
CREATE TABLE [dbo].[Jueces] (
    [juez_id] int IDENTITY(1,1) NOT NULL,
    [juez_fecha_baja] datetime  NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Administradores'
CREATE TABLE [dbo].[Administradores] (
    [administrador_id] int IDENTITY(1,1) NOT NULL,
    [administrador_fecha_baja] datetime  NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Directores'
CREATE TABLE [dbo].[Directores] (
    [director_id] int IDENTITY(1,1) NOT NULL,
    [director_fecha_baja] datetime  NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Tesistas'
CREATE TABLE [dbo].[Tesistas] (
    [tesista_id] int IDENTITY(1,1) NOT NULL,
    [tesista_legajo] nvarchar(max)  NOT NULL,
    [tesista_sede] nvarchar(max)  NOT NULL,
    [tesista_fecha_baja] datetime  NULL,
    [Persona_persona_id] int  NOT NULL
);
GO

-- Creating table 'Tipos_de_mail'
CREATE TABLE [dbo].[Tipos_de_mail] (
    [tipo_mail_id] int IDENTITY(1,1) NOT NULL,
    [tipo_mail_tipo] nvarchar(max)  NOT NULL,
    [tipo_mail_html] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'JuezTesina'
CREATE TABLE [dbo].[JuezTesina] (
    [Jueces_juez_id] int  NOT NULL,
    [Tesinas_tesina_id] int  NOT NULL
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

-- Creating primary key on [tesina_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [PK_Tesinas]
    PRIMARY KEY CLUSTERED ([tesina_id] ASC);
GO

-- Creating primary key on [licenciatura_id] in table 'Licenciaturas'
ALTER TABLE [dbo].[Licenciaturas]
ADD CONSTRAINT [PK_Licenciaturas]
    PRIMARY KEY CLUSTERED ([licenciatura_id] ASC);
GO

-- Creating primary key on [estado_tesina_id] in table 'Estados_tesinas'
ALTER TABLE [dbo].[Estados_tesinas]
ADD CONSTRAINT [PK_Estados_tesinas]
    PRIMARY KEY CLUSTERED ([estado_tesina_id] ASC);
GO

-- Creating primary key on [historial_tesina_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [PK_Historial_estados]
    PRIMARY KEY CLUSTERED ([historial_tesina_id] ASC);
GO

-- Creating primary key on [servidor_id] in table 'Servidores'
ALTER TABLE [dbo].[Servidores]
ADD CONSTRAINT [PK_Servidores]
    PRIMARY KEY CLUSTERED ([servidor_id] ASC);
GO

-- Creating primary key on [envio_id] in table 'Envio_mails'
ALTER TABLE [dbo].[Envio_mails]
ADD CONSTRAINT [PK_Envio_mails]
    PRIMARY KEY CLUSTERED ([envio_id] ASC);
GO

-- Creating primary key on [juez_id] in table 'Jueces'
ALTER TABLE [dbo].[Jueces]
ADD CONSTRAINT [PK_Jueces]
    PRIMARY KEY CLUSTERED ([juez_id] ASC);
GO

-- Creating primary key on [administrador_id] in table 'Administradores'
ALTER TABLE [dbo].[Administradores]
ADD CONSTRAINT [PK_Administradores]
    PRIMARY KEY CLUSTERED ([administrador_id] ASC);
GO

-- Creating primary key on [director_id] in table 'Directores'
ALTER TABLE [dbo].[Directores]
ADD CONSTRAINT [PK_Directores]
    PRIMARY KEY CLUSTERED ([director_id] ASC);
GO

-- Creating primary key on [tesista_id] in table 'Tesistas'
ALTER TABLE [dbo].[Tesistas]
ADD CONSTRAINT [PK_Tesistas]
    PRIMARY KEY CLUSTERED ([tesista_id] ASC);
GO

-- Creating primary key on [tipo_mail_id] in table 'Tipos_de_mail'
ALTER TABLE [dbo].[Tipos_de_mail]
ADD CONSTRAINT [PK_Tipos_de_mail]
    PRIMARY KEY CLUSTERED ([tipo_mail_id] ASC);
GO

-- Creating primary key on [Jueces_juez_id], [Tesinas_tesina_id] in table 'JuezTesina'
ALTER TABLE [dbo].[JuezTesina]
ADD CONSTRAINT [PK_JuezTesina]
    PRIMARY KEY CLUSTERED ([Jueces_juez_id], [Tesinas_tesina_id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [estado_tesis_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_Estado_tesisTesis]
    FOREIGN KEY ([estado_tesis_id])
    REFERENCES [dbo].[Estados_tesinas]
        ([estado_tesina_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Estado_tesisTesis'
CREATE INDEX [IX_FK_Estado_tesisTesis]
ON [dbo].[Tesinas]
    ([estado_tesis_id]);
GO

-- Creating foreign key on [tesina_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [FK_TesisHistorial_estado]
    FOREIGN KEY ([tesina_id])
    REFERENCES [dbo].[Tesinas]
        ([tesina_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TesisHistorial_estado'
CREATE INDEX [IX_FK_TesisHistorial_estado]
ON [dbo].[Historial_estados]
    ([tesina_id]);
GO

-- Creating foreign key on [estado_tesina_id] in table 'Historial_estados'
ALTER TABLE [dbo].[Historial_estados]
ADD CONSTRAINT [FK_Estado_tesisHistorial_estado]
    FOREIGN KEY ([estado_tesina_id])
    REFERENCES [dbo].[Estados_tesinas]
        ([estado_tesina_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Estado_tesisHistorial_estado'
CREATE INDEX [IX_FK_Estado_tesisHistorial_estado]
ON [dbo].[Historial_estados]
    ([estado_tesina_id]);
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

-- Creating foreign key on [persona_id] in table 'Envio_mails'
ALTER TABLE [dbo].[Envio_mails]
ADD CONSTRAINT [FK_PersonaEnvio_mail]
    FOREIGN KEY ([persona_id])
    REFERENCES [dbo].[Personas]
        ([persona_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PersonaEnvio_mail'
CREATE INDEX [IX_FK_PersonaEnvio_mail]
ON [dbo].[Envio_mails]
    ([persona_id]);
GO

-- Creating foreign key on [tesista_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_TesistaTesina]
    FOREIGN KEY ([tesista_id])
    REFERENCES [dbo].[Tesistas]
        ([tesista_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TesistaTesina'
CREATE INDEX [IX_FK_TesistaTesina]
ON [dbo].[Tesinas]
    ([tesista_id]);
GO

-- Creating foreign key on [director_id] in table 'Tesinas'
ALTER TABLE [dbo].[Tesinas]
ADD CONSTRAINT [FK_DirectorTesina]
    FOREIGN KEY ([director_id])
    REFERENCES [dbo].[Directores]
        ([director_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_DirectorTesina'
CREATE INDEX [IX_FK_DirectorTesina]
ON [dbo].[Tesinas]
    ([director_id]);
GO

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

-- Creating foreign key on [Jueces_juez_id] in table 'JuezTesina'
ALTER TABLE [dbo].[JuezTesina]
ADD CONSTRAINT [FK_JuezTesina_Juez]
    FOREIGN KEY ([Jueces_juez_id])
    REFERENCES [dbo].[Jueces]
        ([juez_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Tesinas_tesina_id] in table 'JuezTesina'
ALTER TABLE [dbo].[JuezTesina]
ADD CONSTRAINT [FK_JuezTesina_Tesina]
    FOREIGN KEY ([Tesinas_tesina_id])
    REFERENCES [dbo].[Tesinas]
        ([tesina_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_JuezTesina_Tesina'
CREATE INDEX [IX_FK_JuezTesina_Tesina]
ON [dbo].[JuezTesina]
    ([Tesinas_tesina_id]);
GO

-- Creating foreign key on [tipo_mail_id] in table 'Envio_mails'
ALTER TABLE [dbo].[Envio_mails]
ADD CONSTRAINT [FK_Tipo_mailEnvio_mail]
    FOREIGN KEY ([tipo_mail_id])
    REFERENCES [dbo].[Tipos_de_mail]
        ([tipo_mail_id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Tipo_mailEnvio_mail'
CREATE INDEX [IX_FK_Tipo_mailEnvio_mail]
ON [dbo].[Envio_mails]
    ([tipo_mail_id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------