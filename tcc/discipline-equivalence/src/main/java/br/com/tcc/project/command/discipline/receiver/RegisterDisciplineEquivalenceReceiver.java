package br.com.tcc.project.command.discipline.receiver;

import br.com.portoseguro.payments.common.command.impl.AbstractReceiver;
import br.com.portoseguro.payments.common.gateway.annotation.CommandReceiver;
import br.com.tcc.project.command.RegisterDiscipline;
import br.com.tcc.project.command.discipline.mapper.RegisterDisciplineMapper;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;

@CommandReceiver(RegisterDiscipline.class)
public class RegisterDisciplineReceiver extends AbstractReceiver<RegisterDiscipline.Request, Void> {

  @Autowired @Setter private RegisterDisciplineMapper registerDisciplineMapper;

  @Autowired @Setter private MongoTemplate mongoTemplate;

  @Override
  protected Void doExecute(RegisterDiscipline.Request parameter) {
    mongoTemplate.save(registerDisciplineMapper.map(parameter));
    return null;
  }
}
