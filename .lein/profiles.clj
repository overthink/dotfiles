{:user {
        ;;:dependencies [[lein-light-nrepl "0.0.6"]]
        ;;:repl-options {:nrepl-middleware [lighttable.nrepl.handler/lighttable-ops]}
        :plugins [[cider/cider-nrepl "0.7.0"]
                  [lein-kibit "0.0.8"]
                  [jonase/eastwood "0.1.4"]
                  [lein-deps-tree "0.1.2"]
                  [lein-try "0.2.0"]]}
        :eastwood {:exclude-linters [:wrong-arity]
                   :add-linters [:unused-namespaces]}}
