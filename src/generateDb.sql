CREATE DATABASE IF NOT EXISTS `telegram-notion-saver` CHARACTER SET utf8mb4;
use `telegram-notion-saver`;

CREATE TABLE IF NOT EXISTS `TelegramChats` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `telegramChatId` CHAR(10) UNIQUE NOT NULL,
  `currentTemplateId` INT,
  `chatType` ENUM ('private', 'group', 'supergroup', 'channel')
);

CREATE TABLE IF NOT EXISTS `NotionWorkspaces` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `creatorChatId` INT NOT NULL,
  `workspaceId` CHAR(36) UNIQUE NOT NULL,
  `name` CHAR(255),
  `icon` CHAR(255)
);

CREATE TABLE IF NOT EXISTS `NotionWorkspacesCredentials` (
  `chatId` INT NOT NULL,
  `workspaceId` INT NOT NULL,
  `botId` CHAR(36) NOT NULL,
  `accessToken` CHAR(255) UNIQUE
);

CREATE TABLE IF NOT EXISTS `NotionPages` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `notionPageId` CHAR(36) NOT NULL,
  `workspaceId` INT NOT NULL,
  `pageType` ENUM ('db', 'pg'),
  `icon` CHAR(255),
  `title` CHAR(255),
  `chatId` INT
);

CREATE TABLE IF NOT EXISTS `NotionPagesProps` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `notionPropId` CHAR(255),
  `pageId` INT NOT NULL,
  `propName` CHAR(255),
  `propTypeId` INT
);

DROP TABLE IF EXISTS NotionPropTypes;

CREATE TABLE IF NOT EXISTS `NotionPropTypes` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `type` CHAR(16) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS `Templates` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `pageId` INT,
  `userTemplateNumber` TINYINT NOT NULL,
  `chatId` INT NOT NULL,
  `imageDestination` INT
);

DROP TABLE IF EXISTS ImageDestinations;

CREATE TABLE IF NOT EXISTS `ImageDestinations` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `destinations` CHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS `TemplateRules` (
  `propId` INT,
  `templateId` INT NOT NULL,
  `orderNumber` TINYINT,
  `defaultValue` CHAR(255),
  `endsWith` CHAR(255),
  `urlMetaTemplateRule` INT
);

CREATE TABLE IF NOT EXISTS `UrlMetaTemplateRules` (
  `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `imageDestination` INT,
  `title` INT,
  `description` INT,
  `author` INT,
  `siteName` INT,
  `type` INT
);

ALTER TABLE `TelegramChats` ADD FOREIGN KEY (`currentTemplateId`) REFERENCES `Templates` (`id`);

ALTER TABLE `NotionWorkspaces` ADD FOREIGN KEY (`creatorChatId`) REFERENCES `TelegramChats` (`id`);

ALTER TABLE `NotionWorkspacesCredentials` ADD FOREIGN KEY (`chatId`) REFERENCES `TelegramChats` (`id`);

ALTER TABLE `NotionWorkspacesCredentials` ADD FOREIGN KEY (`workspaceId`) REFERENCES `NotionWorkspaces` (`id`);

ALTER TABLE `NotionPages` ADD FOREIGN KEY (`workspaceId`) REFERENCES `NotionWorkspaces` (`id`);

ALTER TABLE `NotionPages` ADD FOREIGN KEY (`chatId`) REFERENCES `TelegramChats` (`id`);

ALTER TABLE `NotionPagesProps` ADD FOREIGN KEY (`pageId`) REFERENCES `NotionPages` (`id`);

ALTER TABLE `NotionPagesProps` ADD FOREIGN KEY (`propTypeId`) REFERENCES `NotionPropTypes` (`id`);

ALTER TABLE `Templates` ADD FOREIGN KEY (`pageId`) REFERENCES `NotionPages` (`id`);

ALTER TABLE `Templates` ADD FOREIGN KEY (`imageDestination`) REFERENCES `ImageDestinations` (`id`);

ALTER TABLE `Templates` ADD FOREIGN KEY (`chatId`) REFERENCES `TelegramChats` (`id`);

ALTER TABLE `TemplateRules` ADD FOREIGN KEY (`propId`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `TemplateRules` ADD FOREIGN KEY (`templateId`) REFERENCES `Templates` (`id`);

ALTER TABLE `TemplateRules` ADD FOREIGN KEY (`urlMetaTemplateRule`) REFERENCES `UrlMetaTemplateRules` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`imageDestination`) REFERENCES `ImageDestinations` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`title`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`description`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`author`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`siteName`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `UrlMetaTemplateRules` ADD FOREIGN KEY (`type`) REFERENCES `NotionPagesProps` (`id`);

ALTER TABLE `TelegramChats` COMMENT = "Table containing chats info (not users cuz the bot can be added to a grout chat)";

ALTER TABLE `ImageDestinations` COMMENT = "Table containing possible destinations for an extracted image";

ALTER TABLE `UrlMetaTemplateRules` COMMENT = "Table containing rules for URL meta extraction, in what propId to put the extracted content (if NULL discard)";


SET sql_mode='NO_AUTO_VALUE_ON_ZERO';

INSERT INTO ImageDestinations VALUES (0, 'content'), (1, 'cover'), (2, 'icon');
INSERT INTO NotionPropTypes VALUES (0, 'title'), (1, 'rich_text'), (2, 'number'), (3, 'select'), (4, 'multi_select'), (5, 'date'), (6, 'people'), (7, 'files'), (8, 'checkbox'), (9, 'url'), (10, 'email'), (11, 'phone_number'), (12, 'formula'), (13, 'relation'), (14, 'rollup'), (15, 'created_time'), (16, 'created_by'), (17, 'last_edited_time'), (18, 'last_edited_by');
