<%@page import="com.dashboard.workshop.floormgmt.*" %>
<%ClsFloorMgmtDAO dao=new ClsFloorMgmtDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String jobno=request.getParameter("jobno")==null?"0":request.getParameter("jobno");
%>
<script type="text/javascript">
var baydata=[];
var id='<%=id%>';
if(id=="1"){
	baydata='<%=dao.getBayData(id,jobno)%>';
}

	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'doc_no' , type: 'number' },
 						{name : 'code', type: 'string'  },
                      	{name : 'name', type: 'string'  },
                      	{name : 'jobtype',type:'string'},
                      	{name : 'jobtypeid',type:'string'},
                      	{name : 'date',type:'date'},
                      	{name : 'seqno',type:'number'},
             ],
             localdata: baydata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
		$("#bayGrid").on("bindingcomplete", function (event) {
			var rows=$('#bayGrid').jqxGrid('getrows');
			
			for(var i=0;i<rows.length;i++){
				var bayname=$('#bayGrid').jqxGrid('getcellvalue',i,'name');
				if(bayname.includes('Z12')){
					$('#bayGrid').jqxGrid('selectrow',i);
				//	$('#bayGrid').jqxGrid('setcellvalue',i,'seqno',12);
					///alert($('#bayGrid').jqxGrid('getcellvalue',i,'seqno'));
					break;
				}
			}
		});        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#bayGrid").jqxGrid(
                {
                	width: '100%',
                    height: 200,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'checkbox',
                  //pagermode: 'default',
                    //sortable: true,
                    editable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%',editable:false, cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Doc No',datafield: 'doc_no', width: '10%',hidden:true,editable:false },
    					{ text: 'Date',datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy',hidden:true,editable:false },
    					{ text: 'Code',datafield: 'code', width: '15%',hidden:true,editable:false },
    					{ text: 'Name',datafield: 'name', width: '40%' ,editable:false},
    					{ text: 'Job Type',datafield:'jobtype',width: '31%',editable:false},
    					{ text: 'Job Type Id', datafield: 'jobtypeid', width: '10%',hidden:true,editable:false },
    					{ text: 'Seq No', datafield: 'seqno', width: '15%',editable:true}

    	              ]
                });

		$('#bayGrid').on('rowunselect', function (event) 
		{
		    // event arguments.
		    var args = event.args;
		    // row's bound index.
		    var rowBoundIndex = event.args.rowindex;
		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
		    var rowData = event.args.row;
		    var bayname=$('#bayGrid').jqxGrid('getcellvalue',rowBoundIndex,'name');
		    if(bayname.includes('Z12')){
		    	$('#bayGrid').jqxGrid('selectrow', rowBoundIndex);
				return false;
		    }
		});
        	    
		
	});
</script>
<div id="bayGrid"></div>