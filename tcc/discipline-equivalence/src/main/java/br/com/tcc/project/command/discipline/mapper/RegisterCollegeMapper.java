package br.com.tcc.project.command.discipline.mapper;

import br.com.tcc.project.command.RegisterDiscipline;
import br.com.tcc.project.command.mongo.model.DisciplineDocument;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface RegisterDisciplineMapper {

  DisciplineDocument map(RegisterDiscipline.Request source);

}
