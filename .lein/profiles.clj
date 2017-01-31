{:lint {:plugins [[lein-kibit "0.1.3"]
                  [jonase/eastwood "0.2.3"]
                  [lein-bikeshed "0.4.1"]]
        :eastwood {:add-linters [:unused-namespaces
                                 :unused-locals
                                 :keyword-typos]}}
 :user {:plugins [[cider/cider-nrepl "0.9.1"]
                  ;[lein-nodisassemble "0.1.3"]
                  [lein-try "0.4.3"]]
        :dependencies [#_[criterium "0.4.3"]
                       [slamhound "1.5.5"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}}}

