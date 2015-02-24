IsValidFilename(const filename[])
{
	for(new i, len = strlen(filename); i < len; i ++)
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
