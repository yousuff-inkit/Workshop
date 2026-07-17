<%@page import="com.dashboard.operations.repcancel.*"%>
<%ClsRepCancelDAO repcancel=new ClsRepCancelDAO();%>
<%
String agmttype=request.getParameter("agmttype")==null?"":request.getParameter("agmttype");
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String fleetno=request.getParameter("fleetno")==null?"":request.getParameter("fleetno");
String mode=request.getParameter("mode")==null?"0":request.getParameter("mode");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
%>
 <script type="text/javascript">
 var mode='<%=mode%>';
 
 var data;

 if(mode=='1'){
	 data='<%=repcancel.getReplaceData(fromdate,todate,agmtno, fleetno, mode,agmttype,branch)%>';
 }
 $(document).ready(function () { 	
    
        	/*$("#btnExcel").click(function() {
    			$("#repCancelGrid").jqxGrid('exportdata', 'xls', 'Cancel Replacements');
    		});*/            
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'repno', type: 'int' },
     						{name : 'repdate', type: 'date'    },
     						{name : 'agmtno',type: 'string'},
     						{name : 'agmtvocno',type:'string'},
     						{name : 'agmttype',type:'string'},
     						{name : 'cldocno', type: 'string'},
     						{name : 'refname', type: 'string'    },
     						{name : 'dout', type: 'date'   },
     						{name : 'tout',type:'String'},
     						{name : 'fout',type:'string'},
     						{name : 'kmout',type:'number'},
     						{name : 'outbranch',type:'string'},
     						{name : 'outlocation',type:'string'},
     						{name : 'fleet_no',type:'string'},
     						{name : 'reg_no',type:'string'}
     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#repCancelGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	
            });  
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#repCancelGrid").jqxGrid(
            {
                width: '98%',
                height: 522,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							
							{ text: 'Rep No', datafield: 'repno', width: '5%' },
							{ text: 'Rep Date',datafield:'repdate',width:'6%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Agmt Type',datafield:'agmttype',width:'7%'},
							{ text: 'Agmt Original No',datafield:'agmtno',width:'10%',hidden:true},
							{ text: 'Agmt No', datafield: 'agmtvocno', width: '5%' },
							{ text: 'Client', datafield: 'refname', width: '20%' },
							{ text: 'Fleet',datafield:'fleet_no',width:'7%'},
							{ text: 'Reg No',datafield:'reg_no',width:'7%'},
							{ text: 'Date Out', datafield: 'dout', width: '7%' ,cellsformat:'dd.MM.yyyy'},
							{ text: 'Time Out', datafield: 'tout', width: '7%',cellsformat:'HH.mm'},
							{ text: 'Fuel Out', datafield: 'fout', width: '7%'},
							{ text: 'Km Out', datafield: 'kmout', width: '7%'},
							{ text: 'Branch Out',datafield:'outbranch',width:'7%'},
							{ text: 'Location Out',datafield:'outlocation',width:'8%'},
							{ text: 'Cldocno',datafield:'cldocno',width:'7%',hidden:true},
	              ]
            });
            $('#repCancelGrid').on('rowdoubleclick', function (event) 
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
            		    
            		    document.getElementById("txtagmtno").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'agmtno');
            		    document.getElementById("txtagmtvocno").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'agmtvocno');
            		    document.getElementById("txtfleetno").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'fleet_no');
            		    document.getElementById("cmbagmttype").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'agmttype');
     					document.getElementById("temprepno").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'repno');
     					$('#outdate').jqxDateTimeInput('setDate',$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'dout'));
     					$('#outtime').jqxDateTimeInput('setDate',$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'tout'));
     					document.getElementById("outkm").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'kmout');
     					document.getElementById("outfuel").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'fout');
     					document.getElementById("outbrch").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'outbranch');
     					document.getElementById("outloc").value=$('#repCancelGrid').jqxGrid('getcellvalue',boundIndex,'outlocation');
     					
     					/* var repno=document.getElementById("temprepno").value;
     					var outdate=$('#outdate').jqxDateTimeInput('val');
     					var outtime=$('#outtime').jqxDateTimeInput('val');
     					var outkm=document.getElementById("outkm").value;
     					var outfuel=document.getElementById("outfuel").value;
     					var outbranch=document.getElementById("outbrch").value;
     					var outlocation=document.getElementById("outloc").value;
     					 */
     					
            		   // saveData(repno,outdate,outtime,outkm,outfuel,outbranch,outlocation);
            		    
            		});
 });
 
 /* 
 function saveData(repno,outdate,outtime,outkm,outfuel,outbranch,outlocation){
	 var x=new XMLHttpRequest();
		var items,brchItems,currItems,mcloseItems;
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		        items= x.responseText;
		     
		        }
			else
				{
				}
		}
		x.open("GET","saveData.jsp?repno="+repno+"&,true);
		x.send();
 } */
    </script>
    <div id="repCancelGrid"></div>
    <input type="hidden" name="temprepno" id="temprepno">