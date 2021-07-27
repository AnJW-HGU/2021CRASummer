'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Posts', {
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        classification_id: {
            type: Sequelize.SMALLINT,
            allowNull: false
        },
        user_id: {
            type: Sequelize.SMALLINT,
            allowNull: false,
        },
        title: {
            type: Sequelize.STRING(100),
            allowNull: false,
        },
        content: {
            type: Sequelize.TEXT,
            allowNull: false,
        },
        comments_count: {
            type: Sequelize.SMALLINT,
            allowNull: false,
            defaultValue: 0,
        },
        reports_count: {
            type: Sequelize.SMALLINT,
            allowNull: false,
            defaultValue: 0,
        },
        written_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        revised_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        deleted_date: {
            type: Sequelize.DATE,
            allowNull: false,
        },
        adopted_status: {
            type: Sequelize.TINYINT(1),
            allowNull: false
        },
        deleted_status: {
            type: Sequelize.TINYINT(1),
            allowNull: false
        },
  });
},
down: async (queryInterface, Sequelize) => {
  await queryInterface.dropTable('Posts');
}
};
