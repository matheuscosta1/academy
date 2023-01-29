package br.com.tcc.project.command.discipline.mapper;

import br.com.tcc.project.command.RegisterCollege;
import br.com.tcc.project.command.RegisterDiscipline;
import br.com.tcc.project.command.mongo.model.CollegeDocument;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RegisterCollegeMapper {

  CollegeDocument map(RegisterCollege.Request source);

}
