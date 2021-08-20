'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Recommend extends Model {
        static associate(models) {
            // define association here
            this.belongsTo(models.Comment, {
                foreignKey: 'comment_id'
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
        }
    };
    Recommend.init({
        id: {
            primaryKey: true,
            autoIncrement: true,
            type: DataTypes.INTEGER,
            allowNull: false
        },
        completed_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
          },
          deleted_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
          }
    }, {
        sequelize,
        modelName: 'Recommend',
        tableName: 'Recommends',
        createdAt: 'written_date',
        updatedAt: 'revised_date',
    });
    return Recommend;
};
