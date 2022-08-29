# **ptt-blacklab-demo**
This repository demonstrates how to build Blacklab corpus via Docker and Nginx. 

<p align="center">
    <img src="./assest/demo.png" width="100%" height="100%" />
</p>



## **Overview of the Architecture**

```mermaid 
flowchart LR
subgraph Internet
    D[Client]
end

subgraph DOCKER [Docker]

  D --> N{"Load Balancer <br/> (Nginx)"}

  N <==> B["/corpus-frontend"]
  N <==> C["/blacklab-server"]


  C <==> I
  B <==> C
 

  subgraph Indexes
        I[("<div style='padding: 0rem 0.5rem;'>Indexes  <br/>(by Indexer)</div>  ")]
  end


end
```


## **Setup the server**
### 1. Create indexes for Blacklab server

### 2. Build the server



## Contact Me
If you have any suggestion or question, please do not hesitate to email me at philcoke35@gmail.com