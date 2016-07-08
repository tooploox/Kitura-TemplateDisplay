# Kitura-TemplateDisplay
Middleware for [Kitura](https://github.com/IBM-Swift/Kitura).

This middleware adds simple struct implementing `TemplateEngine` protocol. Configured to work with only with Mustache right now.

## Installation

Add this package to your `Package.swift`.

## Use
```
import Kitura
import TemplateDisplay

let renderedString = MustacheTemplateDisplay().render(filePathString, context: yourContext)
```
