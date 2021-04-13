package org.ict.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String uuid;
	private String uploadPath;
	private String name;
	private boolean type;
	
	private Long bno;
}
