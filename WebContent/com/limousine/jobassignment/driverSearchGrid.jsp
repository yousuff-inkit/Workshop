<%@page import="com.limousine.jobassignment.*" %>
<%ClsJobAssignDAO jobdao=new ClsJobAssignDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String name=request.getParameter("name")==null?"":request.getParameter("name");
String mobile=request.getParameter("mobile")==null?"":request.getParameter("mobile");
String license=request.getParameter("license")==null?"":request.getParameter("license");
String date=request.getParameter("date")==null?"":request.getParameter("date");
%>
<script type="text/javascript">
var id='<%=id%>';
var driverdata;
if(id=="1"){
	driverdata='<%=jobdao.getDriverData(docno,name,mobile,license,date,id)%>';
}
$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'doc_no' , type: 'int' },
                       	{name : 'name' , type:'string'},
                       	{name : 'mobile',type:'string'},
                       	{name : 'license',type:'string'},
                       	{name : 'date',type:'date'}
     				   ],
					localdata:driverdata,
                
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

            $("#driverSearchGrid").jqxGrid(
            {
               width: '100%',
               height: 300,
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
							{ text: 'Doc No', datafield: 'doc_no',width:'10%'},
							{ text: 'Date',datafield:'date',cellsformat:'dd.MM.yyyy',width:'10%'},
							{ text: 'Name',  datafield: 'name',width:'50%'},
							{ text: 'Mobile',datafield:'mobile',width:'15%'},
							{ text: 'License',datafield:'license',width:'15%'}
							
         	              ]
           
            });
            
            $("#driverSearchGrid").on("rowdoubleclick", function (event)
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
            		    
            		    document.getElementById("driver").value=$('#driverSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'name');
            		    document.getElementById("hiddriver").value=$('#driverSearchGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');
            		    $('#driverwindow').jqxWindow('close');
            		});
            });

	
            </script>
            <div id="driverSearchGrid"></div>
