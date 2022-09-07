function printGreen() {
    printf "\e[0;32m$1\e[0;m\n"
}

function generateIndex() {
    java -cp "./WEB-INF/lib/*" nl.inl.blacklab.tools.IndexTool $1 $2 ./tei-data/ ./formats/custom.blf.yaml
}

indexDir=./blacklab-data
 

# if blacklab-data folder has indexes, use `add` command
if [ "$(ls -A $indexDir)" ]; then
    echo 'add!'
    generateIndex "add" $indexDir
    printGreen "Blacklab indexes generated: ${indexDir}"
else
    # if blacklab-data folder is empty, use `create` command
    echo 'create!'
    generateIndex "create" $indexDir
    printGreen "Blacklab indexes generated: ${indexDir}"
fi
