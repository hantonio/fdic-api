curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-view": {
      "map": "function(doc){ if(doc.NAME){ emit(doc.NAME, doc); }}"
    }
  },
  "language": "javascript"
}' http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/name
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "asset-view": {
      "map": "function(doc){ if(doc.ASSET){ emit(parseInt(doc.ASSET.replace(\/,\/g, \"\")), doc); }}"
    }
  },
  "language": "javascript"
}' http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/asset
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "name-asset-view": {
      "map": "function(doc){ if(doc.NAME && doc.ASSET){ emit(doc.NAME, doc.ASSET); }}"
    }
  },
  "language": "javascript"
}' http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/name-asset
curl -X PUT -H "Content-Type: application/json" -d '{
  "views": {
    "fed-rssd-view": {
      "map": "function(doc){ if(doc.FED_RSSD){ emit(doc.FED_RSSD); }}"
    }
  },
  "language": "javascript"
}' http://couchdbadmin:couchdbadmin@localhost:5984/fdic_institutions2/_design/fed-rssd
