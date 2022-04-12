package main

import (
	"log"
	"os"

	"github.com/Insight-NA/cloudsql-vault-auth-iap-plugin/plugins/database/cloudsql"
	dbplugin "github.com/hashicorp/vault/sdk/database/dbplugin/v5"
)

func main() {
	err := Run()
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}
}

// Run instantiates a PostgreSQL object, and runs the RPC server for the plugin
func Run() error {
	dbType, err := cloudsql.New()
	if err != nil {
		return err
	}

	//dbplugin.
	dbplugin.Serve(dbType.(dbplugin.Database))

	return nil
}
