package com.solvd.warehouseProject.parsers;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.xml.bind.annotation.adapters.XmlAdapter;

public class LocalDateAdapter extends XmlAdapter <String, LocalDate>{
	private DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	@Override
	public String marshal(LocalDate date) throws Exception {
		return dtf.format(date);
	}

	@Override
	public LocalDate unmarshal(String date) throws Exception {
		return LocalDate.parse(date, dtf);
	}

}
