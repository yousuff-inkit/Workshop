<%@page import="com.dashboard.workshop.wsupdateinsurcomp.*"%>
<%
ClsWSUpdateInsurCompDAO DAO= new ClsWSUpdateInsurCompDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
%>
       
<script type="text/javascript">
var id='<%=id%>';
var data=[];
if(id=="1"){
	data='<%=DAO.getUpdateInsurCompData(fromdate, todate, branch, id)%>';
}
else{
	data=[];
}
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
				{name : 'doc_no', type: 'number'},
				{name : 'voc_no',type:'number'},
				{name : 'date', type: 'date'   },
                {name : 'brhid', type: 'number'   },
                {name : 'branch', type: 'string'   },
                {name : 'cldocno', type: 'string'   },
                {name : 'clientname', type: 'string'   },
                {name : 'insurcldocno', type: 'string'   },
                {name : 'insurcompname', type: 'string'   },
                {name : 'vehdetails', type: 'string'   },
	          ],
                 	localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#updateInsurCompSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 490,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
								{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '4%', cellsrenderer: function (row, column, value) {
								    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
								{ text: 'Doc No', datafield: 'doc_no', width: '8%',hidden:true},
								{ text: 'Doc No', datafield: 'voc_no', width: '8%'},
	      						{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
	      						{ text: 'Branch Id', datafield: 'brhid', width: '20%',hidden:true},
	      						{ text: 'Branch', datafield: 'branch', width: '12%'},
	      						{ text: 'Veh Details', datafield: 'vehdetails', width: '20%'},
	      						{ text: 'Client #', datafield: 'cldocno', width: '8%'},
	      						{ text: 'Client Name', datafield: 'clientname', width: '20%'},
	      						{ text: 'Insur.Comp #', datafield: 'insurcldocno', width: '8%',hidden:true},
	      						{ text: 'Insur.Comp Name', datafield: 'insurcompname', width: '20%'}
                             
                              
						]
            });
            $("#overlay, #PleaseWait").hide();
         	$('#updateInsurCompSearchGrid').on('rowdoubleclick', function (event) 
			{ 
			    var args = event.args;
			    // row's bound index.
			    var boundIndex = event.args.rowindex;
			    // row's visible index.
			    var visibleIndex = event.args.visibleindex;
			    // right click.
			    var rightclick = event.args.rightclick; 
			    // original event.
			    var ev = event.args.originalEvent;
			    
			    $('#gatedocno').val($('#updateInsurCompSearchGrid').jqxGrid('getcellvalue',boundIndex,'doc_no'));
			});
        });
    </script>
    <div id="updateInsurCompSearchGrid"></div>