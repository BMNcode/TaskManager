insert into usr (user_id, username, lastname, password, active)
    values (1, 'flexa1', 'Буленков', '34574Aj341', true),
           (2, 'flexa2', 'Бондарев', '34574Aj342', true),
           (3, 'flexa3', 'Штылев', '34574Aj343', true);

insert into user_role (user_id, roles)
    values (1, 'USER'), (1, 'ADMIN'),
           (2, 'USER'), (2, 'ADMIN'),
           (3, 'USER'), (3, 'ADMIN');