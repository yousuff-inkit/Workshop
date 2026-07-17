<%@page import="com.controlcentre.settings.costcentermaster.ClsCostCenterDAO" %>
<% ClsCostCenterDAO ccd=new ClsCostCenterDAO();%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<html lang="en">
<head>
<style type="text/css">
        .redClass
        {
            
            background-color: #FFEBEB;
        }
        
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .icon {
   width: 2.5em;
   height: 3em;
   border: none;
   background-color: #E0ECF8;
  }
        </style>
<script type="text/javascript">
		
   $(document).ready(function () {
	   var theme = getDemoTheme();
	   $("#excelExport").click(function() {
			$("#ChartOfCosts").jqxGrid('exportdata', 'xls', 'ChartOfCosts');
		});
		//alert("hgcjju");
            // prepare the data
            var data = '<%=ccd.getChartOfCost()%>';

            var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'gp_desc', type: 'string' },
                    { name: 'costgroup', type: 'string' },
                    { name: 'costcode', type: 'string' },
                    { name: 'description', type: 'string' },
                    { name: 'group_name', type: 'string' }
                    
                    
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            var redRow;
            var yellowRow;
            var cellclassname = function (row, column, value, data) {
                if (data.md == 'D') {
                    return "redClass";
                } else if (data.md == 'M') {
                	  return "yellowClass";
                }; 
                
            }; 
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#ChartOfCosts").jqxGrid(
            {
                width: '100%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                //groupsrenderer: false,
                selectionmode: 'singlecell',
                groups: ['costgroup','group_name'],
                columns: [
          
                 /*  { text: 'Group Name', groupable: true, datafield: 'gp_desc', width: '20%' ,cellclassname: cellclassname }, */
                  { text: 'Group Head', groupable: true, datafield: 'costgroup', width: '25%',cellclassname: cellclassname  },
                  { text: 'Main Head', groupable: true, datafield: 'group_name', width: '28%' ,cellclassname: cellclassname },
                  { text: 'Cost Code', groupable: false, datafield: 'costcode', width: '9%',cellclassname: cellclassname  },
                  { text: 'Description', groupable: false, datafield: 'description', width: '37%',cellclassname: cellclassname  }
                ],
				 groupsrenderer: function (defaultText, group, state, params) {
						return false;
					}
				
            });
			
        });
    </script>
</head>
<body class='default'>
<button type="button" class="icon" id="excelExport" title="Export current Document to Excel">
 <img alt="excelDocument" src="<%=contextPath%>/icons/excel_new.png">
</button>
    <div id='jqxWidget'>
        <div id="ChartOfCosts"></div>
    </div>
	
	
	</body>
</html>
 