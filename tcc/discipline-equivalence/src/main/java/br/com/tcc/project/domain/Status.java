package br.com.tcc.project.domain;

import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@EqualsAndHashCode
public class Discipline {
  private Integer workLoad;
  private String originCode;
  private String course;
  private String menu;
  private String college;
  private String name;
  private String program;
}
