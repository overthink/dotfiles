{:user {:plugins [[cider/cider-nrepl "0.8.2"]
                  [lein-kibit "0.0.8"]
                  [jonase/eastwood "0.2.2"]
                  ;[lein-nodisassemble "0.1.3"]
                  [lein-try "0.4.3"]]}
        ;:dependencies [[criterium "0.4.3"]]}
 :eastwood {:exclude-linters [:wrong-arity]
            :add-linters [:unused-namespaces]}}

