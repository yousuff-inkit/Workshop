<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

 <%@page import="javax.servlet.http.HttpServletRequest" %>

 
 <%@page import="com.operations.vehicletransactions.custody.ClsCustodyDAO" %>
 <%
 ClsCustodyDAO viewDAO= new ClsCustodyDAO();
 
  String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();
String fleet=request.getParameter("fleet")==null?"0":request.getParameter("fleet").toString();
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno").toString();
String client=request.getParameter("client")==null?"0":request.getParameter("client").toString();
String agmttype=request.getParameter("agmttype")==null?"0":request.getParameter("agmttype").toString();
String date=request.getParameter("date")==null?"0":request.getParameter("date").toString();
String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile").toString();
String branchsearch=request.getParameter("branchsearch")==null?"0":request.getParameter("branchsearch").toString();


%>

       <script type="text/javascript">
       var radata='<%=viewDAO.getAgmtnoSearch(docno,fleet,regno,client,agmttype,date,mobile,branchsearch)%>';	

        $(document).ready(function () { 	
    
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [

                          	{name : 'doc_no' , type: 'int' },
                         	{name : 'voc_no' , type: 'int' },
     						{name : 'fleet_no', type: 'int'  },
     						{name : 'date', type: 'date'  },
     						{name : 'dout', type: 'date'},
     						{name : 'tout', type: 'String'},
     						{name : 'kmout', type: 'String'},
     						{name : 'fout', type: 'String'},
     						{name : 'obrhid', type: 'String'},
     						{name : 'olocid', type: 'String'}, 
     						{name : 'flname', type: 'String'},
     						{name : 'reg_no', type: 'String'},
     						{name : 'refname',type:'String'},
     						{name : 'branchname',type:'String'},
     						{name : 'loc_name',type:'String'},
     						{name : 'cldocno',type:'String'},
     						{name : 'infleettrancode',type:'String'}
                 ],
                localdata: radata,
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
            $("#gridAgmtSearch").jqxGrid(
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

							{ text: 'Doc No', datafield: 'doc_no', width: '10%' ,hidden:true},
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Fleet', datafield: 'fleet_no', width: '20%' },
							{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Date Out', datafield: 'dout', width: '30%',hidden:true,cellsformat:'dd.MM.yyyy' },
						 	{ text: 'Time Out', datafield: 'tout', width: '30%',hidden:true},
							{ text: 'KM Out', datafield: 'kmout', width: '30%',hidden:true},
							{ text: 'Fuel Out', datafield: 'fout', width: '30%',hidden:true },
							{ text: 'BR Id', datafield: 'obrhid', width: '30%',hidden:true },
							{ text: 'Loc Id', datafield: 'olocid', width: '30%',hidden:true },
							{ text: 'Fleet Name', datafield: 'flname', width: '30%',hidden:true },
							{ text: 'Reg No', datafield: 'reg_no', width: '15%' },
							{ text: 'Client', datafield:'refname',width:'40%'},
							{ text: 'Branch', datafield: 'branchname', width: '30%',hidden:true },
							{ text:'Loc',datafield:'loc_name',width:'30%',hidden:true},
							{ text:'In Fleet Trancode',datafield:'infleettrancode',width:'30%',hidden:true},
							
							{ text:'cldocno',datafield:'cldocno',width:'30%',hidden:true}
							/*	
						{ text: 'Branch', datafield: 'mail1', width: '30%',hidden:true },
							{ text: 'Branch', datafield: 'per_mob', width: '30%',hidden:true } */ 
	              ]
            });
         
            
            $('#gridAgmtSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	
   				document.getElementById("refno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
   				document.getElementById("masterrefno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				var temp="";
				document.getElementById("refname").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "refname");
				document.getElementById("txtfleetno").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
				temp=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "flname");
				temp=temp+",Reg No: "+$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
				document.getElementById("txtfleetname").value=temp;
                $("#refdate").jqxDateTimeInput('val',$("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               // $("#dateouthidden").jqxDateTimeInput('val',$("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "dout"));
               // $("#timeouthidden").jqxDateTimeInput('val',$("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "tout"));
                $("#dateout").jqxDateTimeInput('val',$("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "dout"));
                
                $("#timeout").jqxDateTimeInput('val',$("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "tout"));
                
                $('#cmbfuel').val($("#gridAgmtSearch").jqxGrid('getcellvalue', rowindex1, "fout"));
             	$('#dateout').jqxDateTimeInput('disabled',true);
             	$('#timeout').jqxDateTimeInput('disabled',true);
             	document.getElementById("cmbfuel").disabled=true;
                document.getElementById("outkm").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "kmout");
                document.getElementById("txtbranch").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "branchname");
                document.getElementById("txtlocation").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "loc_name"); 
                document.getElementById("mainbranchid").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "obrhid");
                document.getElementById("mainlocationid").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "olocid");
                document.getElementById("infleettrancode").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "infleettrancode");
                
                document.getElementById("clientnumbers").value=$('#gridAgmtSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
              $('#agmtnowindow').jqxWindow('close');
            });  
           
            });
    </script>
    <div id="gridAgmtSearch"></div>
