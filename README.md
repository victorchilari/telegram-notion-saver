# telegram-notion-saver
Telegram bot to save content to notion database

## Yet Another?

Yes, but this bot is both very flexible and powerful: from a single message it can fill
properties and content of a new database page, so that you no longer have to come back 
later to notion and adjust the saved content. Just set the rules once.

> **IMPORTANT**
> currently only has good supports for adding pages to a database
> 
> adding block to pages works but not very flexible, if you find it not suitable for you send a pull request or switch to another telegram to notion bot

## How it works

First you ```/start``` the bot, it will show you a brief version ofthis guide. 
You will have to authorize the bot as a public integration in Notion, grant access to your workspace and select as many pages as you want.

Then you will have to ```/config``` a template: it is just a collection of rules on how the bot will read and split the information in the messages you send to it,
and where to put these informations, like properties, content or even icon or cover for images. You can also configure the extraction of metatata from one or more urls.
You can even configure default values for properties or content.

You can also configure more than one templates (set of rules) to be able to switch quickly between pages, databases and rules.
You can switch between templates with chat buttons or with ```/use n``` where n is template number.

## Future improvements

- Workspaces & templates can be shared between users
- support for files, audio, stikers etc
- support for url buttons in forwarded messages
- multiple templates active at the same time, automatically determine which one to use looking at formats, link domains, forwarded from, is / contains file
- a template can modify multiple pages (save same content to more than one location with more than one rule)
- notion properties default value for url metadata
- in TemplateRule have different order for parsing and writing (may be useful when writing blocks)
- add possibility to add a sub page block with certain title and content
- regex support for text splitting (instead of endsWith) and text filtering, like having ABC and you want AB in a prop

Still a Work In Progress
