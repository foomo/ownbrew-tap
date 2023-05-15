# Ownbrew Taps

## Usage

Register tap

````bash
$ ownbrew tap foomo/tap
````

## Configuration

Install packages through configuration

````yaml
ownbrew:
  packages:
    - name: gotsrpc
      version: 2.6.2
    - name: helm
      tap: foomo/tap/helm/helm
      version: 3.8.1
    - name: gocontentful
      tap: foomo/tap/foomo/gocontentful
      version: 1.0.11
    - name: gograpple
      tap: foomo/tap/foomo/gograpple
      version: 0.0.19-beta.3
    - name: golangci-lint
      tap: foomo/tap/golangci/golangci-lint
      version: 1.49.0
    - name: husky
      tap: foomo/tap/go-courier/husky
      version: 1.7.0
    - name: hygen
      tap: foomo/tap/jondot/hygen
      version: 6.1.0
    - name: k6
      tap: foomo/tap/grafana/k6
      version: 0.34.1
    - name: k9s
      tap: foomo/tap/derailed/k9s
      version: 0.24.15
    - name: kubectl
      tap: foomo/tap/kubernetes/kubectl
      version: 1.21.2
    - name: kubectl-hns
      tap: foomo/tap/kubernetes-sigs/kubectl-hns
      version: 1.0.0
    - name: kube-prompt
      tap: foomo/tap/c-bata/kube-prompt
      version: 1.0.11
    - name: logfrog
      tap: foomo/tap/foomo/logfrog
      version: 0.2.5
    - name: mockgen
      tap: foomo/tap/golang/mockgen
      version: 1.6.0
    - name: mongo
      tap: foomo/tap/mongodb/mongo
      version: 5.0.5
    - name: mongosh
      tap: foomo/tap/mongodb/mongosh
      version: 1.8.0
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
      version: 100.7.0
    - name: protoc
      tap: foomo/tap/protocolbuffers/protoc
      version: 3.19.1
    - name: protoc-gen-go
      tap: foomo/tap/protocolbuffers/protoc-gen-go
      version: 1.27.1
    - name: protoc-gen-go-grpc
      tap: foomo/tap/grpc/protoc-gen-go-grpc
      version: 1.1.0
    - name: stern
      tap: foomo/tap/stern/stern
      version: 1.21.0
    - name: squadron
      tap: foomo/tap/foomo/squadron
      version: 1.8.1
    - name: terraform
      tap: foomo/tap/hashicorp/terraform
      version: 1.1.9
    - name: terrascan
      tap: foomo/tap/accurics/terrascan
      version: 1.12.0
    - name: terragrunt
      tap: foomo/tap/gruntwork-io/terragrunt
      version: 0.36.7
    - name: tflint
      tap: foomo/tap/terraform-linters/tflint
      version: 0.34.0
    - name: tparse
      tap: foomo/tap/mfridman/tparse
      version: 0.9.0
    - name: zeus
      tap: foomo/tap/dreadl0ck/zeus
      version: 0.9.11
````
