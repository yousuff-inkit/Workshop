<%@page import="com.operations.vehicletransactions.replacementnew.ClsReplacementNewDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno");
String color=request.getParameter("color")==null?"0":request.getParameter("color");
String group=request.getParameter("group")==null?"0":request.getParameter("group");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
ClsReplacementNewDAO repdao=new ClsReplacementNewDAO();
%> 
 <script type="text/javascript">
       var outfleetdata='<%=repdao.getOutFleetSearch(branch,searchdate,fleetno,docno,regno,color,group)%>';	
       
      // alert(id);
       $(document).ready(function () { 	
    	   var id='<%=request.getParameter("id1")%>'; 

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'fleet_no', type: 'int'  },
     						{name : 'din', type: 'date'  },
     						{name : 'tin', type: 'String'},
     						{name : 'kmin', type: 'String'},
     						{name : 'fin', type: 'String'},
     						{name : 'ibrhid', type: 'String'},
     						{name : 'ilocid', type: 'String'}, 
     						{name : 'flname', type: 'String'},
     						{name : 'reg_no', type: 'String'},
     						{name : 'branchname',type:'String'},
     						{name : 'loc_name',type:'String'},
     						{name : 'date',type:'date'},
     						{name :'color',type:'string'},
     						{name :'gid',type:'String'},
     						{name :'doc_no',type:'string'}
     						
                 ],
                localdata: outfleetdata,
                //url: url,
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
            $("#outFleetSearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text:'Doc No',datafield:'doc_no',width:'16.66%'},
							{ text:'Date',datafield:'date',width:'16.66%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Fleet', datafield: 'fleet_no', width: '16.66%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '16.66%'},
							{ text:'Color',datafield:'color',width:'16.66%'},
							{text:'Group',datafield:'gid',width:'16.66%'},
							{ text: 'Date In', datafield: 'din', width: '40%',cellsformat:'dd.MM.yyyy',hidden:true },
						 	{ text: 'Time In', datafield: 'tin', width: '10%',hidden:true},
							{ text: 'KM Out', datafield: 'kmin', width: '30%',hidden:true},
							{ text: 'Fuel Out', datafield: 'fin', width: '30%',hidden:true },
							{ text: 'BR Id', datafield: 'ibrhid', width: '30%',hidden:true },
							{ text: 'Loc Id', datafield: 'ilocid', width: '30%',hidden:true },
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'branchname', width: '30%',hidden:true },
							{ text:'Loc',datafield:'loc_name',width:'30%',hidden:true}
							
							
							
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
            var rows=$("#outFleetSearch").jqxGrid('getrows');
            if(rows.length==0){
            	$("#outFleetSearch").jqxGrid('addrow', null, {});	
            }
            
            $('#outFleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	if(id=="1"){
   				document.getElementById("atbranchoutfleetno").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "fleet_no");
   				var temp="";
   				temp=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "flname");
   				temp=temp+"Reg No: "+$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
   				document.getElementById("atbranchoutfleetname").value=temp;
                document.getElementById("atbranchoutkm").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "kmin");
                $('#cmbatbranchoutfuel').val($("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "fin")) ;
                $('#atbranchoutkm').prop('disabled',true);
                $('#cmbatbranchoutfuel').prop('disabled',true);
                document.getElementById("atbranchoutbranch").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "branchname");
                document.getElementById("hidatbranchoutbranch").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "ibrhid");
                document.getElementById("atbranchoutlocation").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "loc_name");
                var test=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "ilocid");
                if(test==''){
                	test=0;
                }
                document.getElementById("hidatbranchoutlocation").value=test;
            	}
            	else if(id=="2"){
            		document.getElementById("coloutfleetno").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "fleet_no");
       				var temp="";
       				temp=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "flname");
       				temp=temp+"Reg No: "+$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "reg_no");
       				document.getElementById("coloutfleetname").value=temp;
                    document.getElementById("coloutkm").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "kmin");
                    $('#cmbcoloutfuel').val($("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "fin")) ;
                    $('#coloutkm').prop('disabled',true);
                    $('#cmbcoloutfuel').prop('disabled',true);
                    document.getElementById("coloutbranch").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "branchname");
                    document.getElementById("hidcoloutbranch").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "ibrhid");
                    document.getElementById("coloutlocation").value=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "loc_name");
                    var test=$("#outFleetSearch").jqxGrid('getcellvalue', rowindex1, "ilocid");
                    if(test==''){
                    	test=0;
                    }
                    document.getElementById("hidcoloutlocation").value=test;
            	}
              $('#vehiclewindow').jqxWindow('close');
            });  
        });
    </script>
    <div id="outFleetSearch"></div>
