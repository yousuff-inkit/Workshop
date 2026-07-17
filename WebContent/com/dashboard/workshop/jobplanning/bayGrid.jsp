<%@page import="com.dashboard.workshop.jobplanning.*" %>
<%ClsWSJobPlanningDAO dao=new ClsWSJobPlanningDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>
<script type="text/javascript">
var baydata=[];
var id='<%=id%>';
if(id=="1"){
	baydata='<%=dao.getBayData(id)%>';
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
                  //  pagermode: 'default',
                    sortable: true,
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

        $('#bayGrid').on('rowdoubleclick', function (event) 
        		{    
                var row1=event.args.rowindex;
    			$('#docno').val($('#bayGrid').jqxGrid('getcellvalue',row1,'doc_no'));
    			$('#code').val($('#bayGrid').jqxGrid('getcellvalue',row1,'code'));
    			$('#cmbjobtype').val($('#bayGrid').jqxGrid('getcellvalue',row1,'jobtypeid'));
    			$('#name').val($('#bayGrid').jqxGrid('getcellvalue',row1,'name'));
    			$('#date ').jqxDateTimeInput('setDate',$('#bayGrid').jqxGrid('getcellvalue',row1,'date'));
                });
            
        $('#bayGrid').jqxGrid('selectrow', 11);
            
		$('#bayGrid').on('rowunselect', function (event) 
		{
		    // event arguments.
		    var args = event.args;
		    // row's bound index.
		    var rowBoundIndex = event.args.rowindex;
		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
		    var rowData = event.args.row;
			if(rowBoundIndex==11){
				$('#bayGrid').jqxGrid('selectrow', rowBoundIndex);
				return false;
			}
		});
        	    
	
        		
	});
</script>
<div id="bayGrid"></div>