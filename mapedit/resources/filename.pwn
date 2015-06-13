IsValidFilename(const filename[])
{
    new len = strlen(filename);
    if(len == 0)
        return 0;

    for(new i; i < len; i ++)
    {
        if(
            filename[i] == '/' ||
            filename[i] == '?' ||
            filename[i] == '<' ||
            filename[i] == '>' ||
            filename[i] == '\\' ||
            filename[i] == ':' ||
            filename[i] == '*' ||
            filename[i] == '|'
        ){
            return 0;
        }
    }
    return 1;
}
