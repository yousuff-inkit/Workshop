<%@page import="com.limousine.jobassignment.*" %>
<%ClsJobAssignDAO jobdao=new ClsJobAssignDAO();
String uptodate=request.getParameter("uptodate")==null?"":request.getParameter("uptodate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
<script type="text/javascript">
var id='<%=id%>';
var counterdata;
if(id=="1"){
	counterdata='<%=jobdao.getBookCounterData(uptodate,id,branch)%>';
}
$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'refname' , type:'string'}
     				   ],
					localdata:counterdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#bookCounterGrid").jqxGrid(
            {
               width: '100%',
               height: 250,
               source: dataAdapter,
               columnsresize: true,
               //disabled:true,
               editable:false,
               selectionmode: 'singlerow',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',width:'30%'},
							{ text: 'Client',  datafield: 'refname',width:'70%'}
         	              ]
           
            });
            
            $("#bookCounterGrid").on("rowdoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		    
            		    $('#bookdetaildiv').load('bookDetailGrid.jsp?bookdocno='+$('#bookCounterGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no')+'&id=1&branch='+document.getElementById("brchName").value);
            		});
            });

	
            </script>
            <div id="bookCounterGrid"></div>
