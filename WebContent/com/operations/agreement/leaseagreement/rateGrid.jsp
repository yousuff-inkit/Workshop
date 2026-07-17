
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<style>
.column{
background-color: #D6FFEA;
}
</style>
 <%@page import="com.operations.agreement.leaseagreement.ClsLeaseAgreementDAO" %>
 <%
 ClsLeaseAgreementDAO viewDAO= new ClsLeaseAgreementDAO();

	String relodedoc = request.getParameter("rateGriddocno")==null?"0":request.getParameter("rateGriddocno").trim();%>
 


 
   
   	
<script type="text/javascript">

var temp2='<%=relodedoc%>'; 

if(temp2>0)
{

	 var agmtdata='<%=viewDAO.tariffratereload(session,relodedoc)%>';

}
else
{ 
var agmtdata;
/* 	 /* '[{"Name":""},{"Date of Birth":""},{"Age":""},{"dbage":""},{"Nationality":""},{"Mob No":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Licence#":""},{"Lic Issued":""},{"dbLic Issued":""},{"calcuLic Issued":""},{"Lic Expiry":""},{"Lic Type":""},{"Iss From":""},{"Passport#":""},{"Pass Exp":""},{"doc_no":""}]'; */
} 
     $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}

        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
									{name : 'rentaltype' , type: 'string', },
									{name : 'rate' , type:'number'},
									{name : 'cdw' , type:'number'},
									{name : 'pai' , type:'number'},
									{name : 'cdw1' , type:'number'},
									{name : 'pai1' , type:'number'},
									{name : 'gps' , type:'number'},
									{name : 'babyseater' , type:'number'},
									{name : 'cooler' , type:'number'},
									{name : 'exhrchg' , type:'number'},
									{name : 'chaufchg' , type:'number'},
									{name : 'chaufexchg' , type:'number'},
									{name : 'kmrest' , type:'number'},
									{name : 'exkmrte' , type:'number'},
									{name : 'oinschg' , type:'number'}
                 ],
                localdata: agmtdata,
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
            $("#rateGrid").jqxGrid(
            {
                width: '100%',
                height: 45,
                source: dataAdapter,
                rowsheight:18,
                columnsresize: true,
                pageable: false,
                disabled:true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                editable:true,
                //Add row method
                columns: [
                          
   				
                          
   				{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: '      '+document.getElementById("maincdw").value,     datafield: 'cdw', editable:true ,renderer: columnsrenderer,cellsformat: 'd2' , cellsalign: 'right', align: 'right',cellclassname:'column'},
				{ text: '     '+document.getElementById("mainpai").value,   datafield: 'pai',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
				{ text: '     '+document.getElementById("maincdw1").value,   datafield: 'cdw1',  editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: '     '+document.getElementById("mainpai1").value,   datafield: 'pai1',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'},
				{ text: '     '+document.getElementById("maingps").value,  datafield: 'gps',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("mainbabyseater").value,   datafield: 'babyseater', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("maincooler").value,  datafield: 'cooler',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("mainkmrest").value,   datafield: 'kmrest',  editable:true,renderer: columnsrenderer,cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("mainexkmrte").value, datafield: 'exkmrte',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("mainchaufchg").value,   datafield: 'chaufchg',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right',align: 'right',cellclassname:'column'},
				{ text: ''+document.getElementById("mainchaufexchg").value,   datafield: 'chaufexchg', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellsalign: 'right', align: 'right',cellclassname:'column'}
	              ]
            });
            
          
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
            $('#rateGrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
           
            
            
            
            if ($("#mode").val() == "view") {
         	   $("#rateGrid").jqxGrid({ disabled: true});
           }
            
            if ($("#mode").val() == "A") {
            	   
            	  
                $("#rateGrid").jqxGrid({ disabled: false});
             
           	 
               }
              
            var rows = $('#rateGrid').jqxGrid('getrows');
            var rowslength=rows.length;
            if(rowslength==0){
            $("#rateGrid").jqxGrid("addrow", null, {});
            }
            /* $('#tarifagmtgrid').on('bindingcomplete', function (event) {
             	// alert("Heree");
             	
         	    var rows = $('#tarifreferencegrid').jqxGrid('getrows');
                var rowslength=rows.length;
                //$("#tarifreferencegrid").jqxGrid('setcellvalue', rowslength, datafield, oldvalue);
         	   }); */
        });
  
            </script>
            <div id="rateGrid"></div>
        <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include> 