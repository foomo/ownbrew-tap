# MongoDB

## Shell ([releases](https://www.mongodb.com/try/download/shell))

```yaml
ownbrew:
  packages:
    - name: mongosh
      tap: foomo/tap/mongodb/mongosh
      version: 1.10.3
```

## Database Tools ([releases](https://www.mongodb.com/download-center/database-tools/releases/archive))

```yaml
ownbrew:
  packages:
    - name: mongotools
      names:
        - bsondump
        - mongodump
        - mongoexport
        - mongofiles
        - mongoimport
        - mongorestore
        - mongostat
        - mongotop
      tap: foomo/tap/mongodb/mongotools
      version: 100.7.4
```

## Shell (deprecated)

```yaml
ownbrew:
  packages:
    - name: mongo
      tap: foomo/tap/mongodb/mongo
      version: 5.0.5
```
