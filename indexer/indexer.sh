function printGreen() {
    printf "\e[0;32m$1\e[0;m\n"
}

function generateIndex() {
    java -cp "./WEB-INF/lib/*" nl.inl.blacklab.tools.IndexTool $1 $2 ./tei-data/ ./formats/custom.blf.yaml
}

indexDir=./blacklab-data
 
# if blacklab-data folder exists, use `add` command
if [ -d "${indexDir}" ]; then 
    generateIndex "add" $indexDir
fi 

# if blacklab-data folder exists, use `create` command
if [ ! -d "$Directory" ]; then
    generateIndex "create" $indexDir
fi 

printGreen "Blacklab indexes generated: ${indexDir}"