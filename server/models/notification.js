'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
    class Notification extends Model {
        static associate(models) {
            // define association here
            this.belongsTo(models.Post, {
                foreignKey: 'post_id'
            });
            this.belongsTo(models.User, {
                foreignKey: 'user_id'
            });
        }
    };
    Notification.init({
        kind: {
            type: DataTypes.STRING,
            allowNull: false
        },
        read_status: {
            type: DataTypes.INTEGER,
            allowNull: false,
            default: 0
        },
    }, {
        sequelize,
        modelName: 'Notification',
        tableName: 'Notifications',
        createdAt: 'written_date',
        updatedAt: 'read_date',
    });
    return Notification;
};
