<%@page import="com.dashboard.workshop.gipmgmt.*" %>
<%ClsGIPMgmtDAO floordao=new ClsGIPMgmtDAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno")==""?"":request.getParameter("gatedocno");
%>

<script type="text/javascript">
var gatedocno='<%=gatedocno%>';
var baymovdata1=[];
	baymovdata1='<%=floordao.getChecklistdata(gatedocno)%>';   

	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'description' , type: 'string'},
 						{name : 'answer', type: 'string'},
 						
                      	
             ],
             localdata: baymovdata1,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#checklistGrid").jqxGrid(
                {
                	width: '100%',
                    height: 400,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:true,
                    altrows:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: '',datafield: 'description', width: '26%',editable:false},
    					{ text: 'Answer',datafield: 'answer', width: '70%',editable:true},
    						
						
    	              ]
                });

	});
</script>
<div id="checklistGrid"></div>