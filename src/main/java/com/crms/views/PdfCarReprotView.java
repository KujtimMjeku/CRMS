package com.crms.views;

import java.awt.Color;
import java.awt.Toolkit;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.crms.entity.Car;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class PdfCarReprotView extends AbstractPdfView {

	@SuppressWarnings("unchecked")
	@Override
	protected void buildPdfDocument(Map<String, Object>  model, 
			Document document,
			PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		List<Car> carData = (List<Car>) model.get("carList");
		
		

		PdfPTable table = new PdfPTable(8);
		table.addCell("");
		table.addCell("Emri");
		table.addCell("Tipi");
		table.addCell("Numri Regjistrimit");
		table.addCell("Ngjyra");
		table.addCell("Data prodhimit");
		table.addCell("Cmimi ditor");
		table.addCell("Foto");
		int n=1;
		Font f=FontFactory.getFont(FontFactory.COURIER,11,Color.DARK_GRAY);
		for (Car car : carData) {
			
			table.addCell(new Phrase(Integer.toString(n),f));
			table.addCell(new Phrase(car.getTblcarType().getName(),f));
			table.addCell(new Phrase(car.getTblcarType().getType(),f));
			table.addCell(new Phrase(car.getRegjistration_Number(),f));
			table.addCell(new Phrase(car.getColor(),f));
			table.addCell(new Phrase(car.getDate_of_Manufacturing().toString(),f));
			table.addCell(new Phrase(Float.toString(car.getBase_Price_Per_Day()),f));
			if(car.getImage() != null)
			{
				System.out.println(car.getImage_name());
				//java.awt.Image im = Toolkit.getDefaultToolkit().createImage(car.getImage());
				Image img = Image.getInstance(car.getImage());
				PdfPCell cell = new PdfPCell(img, true);
				table.addCell(cell);
			}
			else
			{
				table.addCell("");
			}
			n++;
		}
		document.add(table);
	}
}
