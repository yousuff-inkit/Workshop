<%@page import="com.operations.agreement.rentalclosesayara.*" %>
<%ClsRentalCloseSayaraDAO rcd=new ClsRentalCloseSayaraDAO(); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title id='Description'>The Grid's columns and rows in this examples are retrieved from JSON file.</title>
    <link rel="stylesheet" href="../../../../jqwidgets/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="../../../../scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="../../../../jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="../../../../scripts/demos.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var url = "../../../common/rows_and_columns.txt";
            // prepare the data
            var source =
            {
                datatype: "json",
                url: url
            };
            var dataAdapter = new $.jqx.dataAdapter(source, {
                autoBind: true,
                downloadComplete: function (data) {
                    var columns = data[0].columns;
                    alert(columns);
                    //var rows = data[1].rows;
                    var rows = '<%=rcd.getTotalData_view("18")%>'; 
                    var gridAdapter = new $.jqx.dataAdapter({
                        datafields: [
                        { name: 'rentaltype', type: 'string' },
                        { name: 'tarif', type: 'string' },
                        { name: 'cdw', type: 'string' },
                        { name: 'pai', type: 'string' },
                        { name: 'scdw', type: 'string' },
                        { name: 'spai', type: 'string' }
                        ],
                         id: 'id', 
                      	 localdata: rows
                    });

                    $("#jqxgrid").jqxGrid('hideloadelement');
                    $("#jqxgrid").jqxGrid('beginupdate', true);
                    $("#jqxgrid").jqxGrid(
                      {
                          source: gridAdapter,
                          columns: columns
                      });
                    $("#jqxgrid").jqxGrid('endupdate');
                }
            });
            $("#jqxgrid").jqxGrid(
                   {
                       width: 850,
                       columnsresize: true
                   });
            $("#jqxgrid").jqxGrid('showloadelement');
        });
    </script>
</head>
<body class='default'>
    <div id="jqxgrid"></div>
</body>
</html>
