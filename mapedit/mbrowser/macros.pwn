#define GetPlayerMBrowser(%0) \
    (g_mbID[%0])

#define HideMBrowserListItem(%0,%1) \
    (PlayerTextDrawHide(%0, g_mbListTD[%0][%1]))

#define HideMBrowserSearch(%0) \
    (PlayerTextDrawHide(%0, g_mbSearchTD[%0][1]))
