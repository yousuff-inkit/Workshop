<%@page import="com.dashboard.workshop.floormgmt.*" %>
<%ClsFloorMgmtDAO dao=new ClsFloorMgmtDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String jobdocno=request.getParameter("jobdocno")==null?"0":request.getParameter("jobdocno");
%>
<script type="text/javascript">
var techdata=[];
var id='<%=id%>';
if(id=="1"){
	techdata='<%=dao.getSelectedTechData(id,jobdocno)%>';
}

	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'techname' , type: 'string' },
 						{name : 'remarks', type: 'string'  },
                      	{name : 'esthrs', type: 'string'  }
             ],
             localdata: techdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
		$("#selectedTechGrid").on("bindingcomplete", function (event) {
			
		});        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#selectedTechGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  //pagermode: 'default',
                    //sortable: true,
                    editable: false,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Technician',datafield: 'techname', width: '30%' },
    					{ text: 'Remarks',datafield: 'remarks', width: '55%'},
    					{ text: 'Est.Hrs',datafield: 'esthrs', width: '10%'}
    	              ]
                });		
	});
</script>
<div id="selectedTechGrid"></div>