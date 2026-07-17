<%@page import="com.workshop.setup.jobmaster.ClsJobMasterDAO" %>
<%ClsJobMasterDAO dao=new ClsJobMasterDAO();
String check=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
System.out.println(docno);
%>

<script type="text/javascript">
var check='<%=check%>';
var jobgrid;
if(check=="1"){
	jobgrid='<%=dao.loadgrid(docno)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [ 
                      	{name : 'desc' , type: 'string' },
                      	/* {name : 'doc_no' , type: 'string' },
                      	{name : 'date' , type: 'string' },
                      	{name : 'type' , type: 'string' },
                      	{name : 'jobid' , type: 'string' }, */
             ],
             localdata: jobgrid,
            
            
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



        $("#jobDescGrid").jqxGrid(
                {
                	width: '100%',
                    height: 340,
                    source: dataAdapter,
                   /*  showfilterrow: true,
                    filterable: true, */
                    selectionmode: 'singlecell',
                    editable:true,
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    
		              //Add row method
		                handlekeyboardnavigation: function (event) {
		
		                   var cell = $('#jobDescGrid').jqxGrid('getselectedcell');
		                   if (cell != "undefined" && cell.datafield == 'desc') {
		                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                       if (key == 9) {  
		                    	   var rows = $('#jobDescGrid').jqxGrid('getrows');
		                           var rowlength= rows.length;
		                           var rowindex2 = rowlength - 1;
		                      	    var jobdesc=$("#jobDescGrid").jqxGrid('getcellvalue', rowindex2, "desc");
			                       	if(typeof(jobdesc) != "undefined" && jobdesc != "" ){
			                       		 $("#jobDescGrid").jqxGrid("addrow", null, {});
			                       	} 
		                       }
		                   } 
		               },
		               
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
					//	{ text: 'Doc_no',datafield: 'doc_no', width: '5%' ,hidden:true},
					//	{ text: 'Date',datafield: 'date', width: '10%' },
					//	{ text: 'JobType',datafield: 'type', width: '10%' },
    					{ text: 'Description',datafield: 'desc', width: '95%' },
    				//	{ text: 'JobTypeid',datafield: 'jobid', width: '5%',hidden:true },

    	              ]
                });
      //  $("#jobDescGrid").jqxGrid("addrow", null, {});
        /* $("#jobDescGrid").on("rowclick", function (event) {
        	 var row1=event.args.rowindex;
        	 var rows = $('#jobDescGrid').jqxGrid('getrows');
             var rowlength= rows.length;
             var rowindex2 = rowlength - 1;
        	 var jobdesc=$("#jobDescGrid").jqxGrid('getcellvalue', rowindex2, "desc");
        	 if(typeof(jobdesc) != "undefined" && jobdesc != "" ||rowindex2==row1 ){
        		 $("#jobDescGrid").jqxGrid("addrow", null, {});
        	 }
        	
        }); */
        $("#jobDescGrid").on("rowdoubleclick", function (event) {
            var row1=event.args.rowindex;
           /*  $('#docno').attr('readonly', false);    
			$('#docno').val($('#jobDescGrid').jqxGrid('getcellvalue',row1,'doc_no'));
			$('#docno').attr('readonly', true);
			$('#hidcmbjobtype').val($('#jobDescGrid').jqxGrid('getcellvalue',row1,'jobid'));
			$('#cmbjobtype').val($('#jobDescGrid').jqxGrid('getcellvalue',row1,'jobid'));
			$('#description').val($('#jobDescGrid').jqxGrid('getcellvalue',row1,'desc'));
			$('#date ').jqxDateTimeInput('setDate',$('#jobDescGrid').jqxGrid('getcellvalue',row1,'date'));
            */ }); 
        
        

	});
</script>
<div id="jobDescGrid"></div>