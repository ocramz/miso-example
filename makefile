GHC8 := stack-ghcjs-8.0.1.yaml
GHC7 := stack-ghcjs-7.10.3.yaml 

build-7:
	stack build --stack-yaml=${GHC7}

build-8:
	stack build --stack-yaml=${GHC8}

ghci-7:
	stack ghci --stack-yaml=${GHC7}

ghci-8:
	stack ghci --stack-yaml=${GHC8}

